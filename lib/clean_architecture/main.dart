import 'injection_container.dart';
import 'presentation/bloc/user/main/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/pages/user/user_screen.dart';

void callApp() async {
  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<UserBloc>()..add(GetAll()),
          ),
        ],
        child: const UserScreen(),
      ),
    );
  }
}
