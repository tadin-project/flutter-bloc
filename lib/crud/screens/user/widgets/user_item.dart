import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'confirm.dart';
import 'go_form_screen.dart';
import '../../../bloc/user/main/user_bloc.dart';
import '../../../models/user.dart';

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(user.name),
                  const SizedBox(
                    width: 4,
                  ),
                  badgeRole(user.roleId, user.roleName),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  goFormScreen(context, user: user);
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                  onPressed: () {
                    showAlertDialog(
                      context,
                      onConfirm: () {
                        context.read<UserBloc>().add(DeleteUser(user.id!));
                        Navigator.of(context).pop();
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget badgeRole(int roleId, String? roleName) {
    Color? roleColor = roleId == 1
        ? Colors.green
        : roleId == 2
            ? Colors.blue[900]
            : Colors.black;
    return Container(
      decoration: BoxDecoration(
        color: roleColor,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(4),
      child: Text(
        roleName ?? "Unknown",
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
