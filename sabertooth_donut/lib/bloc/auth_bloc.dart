import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

abstract class AuthEvents {}

class SigninEvent extends AuthEvents {
  final String? email;
  final String? password;

  SigninEvent(this.email, this.password);
}

class SignupEvent extends AuthEvents {
  final String? email;
  final String? password;

  SignupEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvents {}

class AuthBloc extends Bloc<AuthEvents, User?> {
  Logger logger = Logger();
  AuthBloc(super.user) {
    on<SigninEvent>((event, emit) async {
      try {
        var creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email!,
          password: event.password!
        );
        emit(creds.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          logger.e('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          logger.e('Wrong password provided for that user.');
        }
      }
    });

    on<SignupEvent>((event, emit) async {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email!,
        password: event.password!
      );
      try {
        var creds = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email!,
          password: event.password!
        );
        emit(creds.user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          logger.e('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          logger.e('The account already exists for that email.');
        }
      } catch (e) {
        logger.e(e);
      }
    });

    on<LogoutEvent>((event, emit) async {
      if (state != null) {
        await FirebaseAuth.instance.signOut();
        emit(FirebaseAuth.instance.currentUser);
      }
    });
  }
}