import '../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/user/user_form_screen.dart';
import '../../bloc/user/form/role_bloc.dart';
import '../../bloc/user/form/user_form_bloc.dart';
import '../../bloc/user/main/user_bloc.dart';
import '../../../domain/entities/user.dart';

void goFormScreen(BuildContext context, {User? user}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<RoleBloc>(
            create: (context) => sl<RoleBloc>(),
          ),
          BlocProvider<UserFormBloc>(
            create: (context) => sl<UserFormBloc>(),
          ),
        ],
        child: UserFormScreen(
          user: user,
        ),
      ),
    ),
  ).then((value) {
    if (value != null) {
      // ignore: use_build_context_synchronously
      context.read<UserBloc>().add(GetAll());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$value')));
    }
  });
}
