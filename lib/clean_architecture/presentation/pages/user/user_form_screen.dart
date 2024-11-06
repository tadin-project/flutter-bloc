import '../../../data/models/user/user_model.dart';
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
  final TextEditingController roleC = TextEditingController();

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
      roleC.text = currUser.roleId.toString();
    }
  }

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passwordC.dispose();
    roleC.dispose();
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
            builder: (BuildContext context2, state2) {
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
                        AppInput(
                          label: "Role",
                          controller: roleC,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              if (state is! UserFormLoading) {
                                if (widget.user != null) {
                                  context.read<UserFormBloc>().add(
                                        UpdateUser(
                                          UserModel(
                                            email: emailC.text,
                                            name: nameC.text,
                                            password: passwordC.text,
                                            roleId: int.parse(roleC.text),
                                            id: widget.user!.id!,
                                          ),
                                        ),
                                      );
                                } else {
                                  context.read<UserFormBloc>().add(
                                        AddUser(
                                          UserModel(
                                            email: emailC.text,
                                            name: nameC.text,
                                            password: passwordC.text,
                                            roleId: int.parse(roleC.text),
                                          ),
                                        ),
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
