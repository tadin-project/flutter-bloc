import 'package:crud_bloc/clean_architecture/presentation/widgets/user/app_select.dart';

import '../../../domain/entities/user.dart';
import '../../bloc/user/form/role_bloc.dart';
import '../../bloc/user/form/user_form_bloc.dart';
import '../../widgets/user/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFormScreen extends StatefulWidget {
  final User? user;
  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  int roleId = 1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RoleBloc>().add(GetRoles());
    });
    if (widget.user != null) {
      User currUser = widget.user!;
      nameC.text = currUser.name;
      emailC.text = currUser.email;
      roleId = currUser.roleId;
    }
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserFormBloc, UserFormState>(
      listener: (context, state) {
        if (state is UserFormSuccess) {
          Navigator.pop(context, state.message);
        }
      },
      child: BlocBuilder<UserFormBloc, UserFormState>(
        builder: (context, state) {
          return BlocBuilder<RoleBloc, RoleState>(
            builder: (BuildContext roleContext, roleState) {
              return Scaffold(
                appBar: AppBar(
                  title:
                      Text("${widget.user != null ? "Update" : "Tambah"} User"),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        state is UserFormError
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4)),
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Error",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      state.message,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        AppInput(
                          label: "Name",
                          controller: nameC,
                        ),
                        AppInput(
                          label: "Email",
                          controller: emailC,
                        ),
                        AppInput(
                          label: "Password",
                          controller: passwordC,
                        ),
                        AppSelect<int>(
                          label: "Role",
                          items: roleState is RoleLoaded
                              ? roleState.roles
                                  .map(
                                    (role) => DropdownMenuItem(
                                      value: role.id!,
                                      child: Text(
                                        role.name,
                                      ),
                                    ),
                                  )
                                  .toList()
                              : [],
                          value: roleId,
                          onChanged: (int? id) {
                            if (id != null) {
                              setState(() {
                                roleId = id;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              if (state is! UserFormLoading) {
                                User userData = User(
                                    name: nameC.text,
                                    email: emailC.text,
                                    password: passwordC.text,
                                    roleId: roleId);
                                if (widget.user != null) {
                                  userData =
                                      userData.copyWith(id: widget.user!.id);
                                  context.read<UserFormBloc>().add(
                                        UpdateUser(userData),
                                      );
                                } else {
                                  context.read<UserFormBloc>().add(
                                        AddUser(userData),
                                      );
                                }
                              }
                            },
                            child: Text(state is UserFormLoading
                                ? "Loading..."
                                : "Save")),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
