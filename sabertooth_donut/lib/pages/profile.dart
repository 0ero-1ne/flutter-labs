import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabertooth_donut/bloc/auth_bloc.dart';
import 'package:sabertooth_donut/pages/auth/login.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  const ProfilePage({ super.key });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    
    return Scaffold(
      body: BlocBuilder<AuthBloc, User?>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
                state != null ?
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          state.email!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      FilledButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                        ),
                        onPressed: () => bloc.add(LogoutEvent()),
                        child: const Text(
                          "Sign out",
                          style: TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  )
                  :
                  FilledButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)
                    ),
                    onPressed: () async {
                      Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}