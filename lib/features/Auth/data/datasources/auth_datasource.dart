import 'package:belajar_clean_arsitectur/features/auth/data/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UsersModel> signInWithEmailAndPassword(String email, String password);
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password);
  Future<UsersModel> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImplementation extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final Box box;

  AuthRemoteDataSourceImplementation({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.box,
  });

  @override
  Future<UsersModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      Box userBox = Hive.box('box');
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
     
      final userDoc = await firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      await userBox.put('uid', credential.user!.uid);
      await userBox.put('name', userDoc.data()!['name']);
      await userBox.put('email', userDoc.data()!['email']);
      await userBox.put('photoUrl', userDoc.data()!['photoUrl']);

      return UsersModel.fromJson(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided.');
      }
      throw Exception('Login error: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        await firebaseFirestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'photoUrl': user.photoURL ?? '',
          'isVerified': user.emailVerified,
          'createdAt': FieldValue.serverTimestamp(),
        });
        return UsersModel.fromJson(user);
      } else {
        throw Exception('Failed to create user.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Password terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Email sudah digunakan.');
      }
      throw Exception('Register error: ${e.message}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UsersModel> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
