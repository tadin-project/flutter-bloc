import '../../../domain/entities/user.dart';
import '../../widgets/user/go_form_screen.dart';
import '../../widgets/user/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/main/user_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List User"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(GetAll());
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: renderBody(context, state),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goFormScreen(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget renderBody(BuildContext context, UserState state) {
    if (state is UserLoaded) {
      return ListView.builder(
        itemCount: state.users.length,
        itemBuilder: (context, index) {
          User user = state.users[index];
          return UserItem(user: user);
        },
      );
    } else if (state is UserLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(
        child: Text("Empty Data"),
      );
    }
  }
}
