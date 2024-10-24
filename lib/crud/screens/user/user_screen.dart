import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/go_form_screen.dart';
import 'widgets/user_item.dart';
import '../../bloc/user/main/user_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetAll()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("User Data"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<UserBloc>().add(GetAll());
                          },
                          child: const Text("Refresh")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  listData(context, state),
                  const SizedBox(height: 50),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                goFormScreen(context);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  Widget listData(BuildContext context, UserState state) {
    if (state is UserLoading) {
      return const CircularProgressIndicator();
    } else if (state is UserLoaded) {
      return Expanded(
        child: ListView.builder(
          itemCount: state.data.length,
          itemBuilder: (context, index) => UserItem(
            user: state.data[index],
          ),
        ),
      );
    } else {
      return Center(
        child: Text(state is UserError ? state.message : "Error unknown"),
      );
    }
  }
}
