import 'package:builder_bloc_template/core/config/error/exception.dart';
import 'package:builder_bloc_template/core/di/service_locator.dart';
import 'package:builder_bloc_template/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

abstract class AuthDatasource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> registrasi(String email, String password);
}

class AuthDatasourceImpl extends AuthDatasource {
  final FirebaseAuth firebaseAuth;

  AuthDatasourceImpl(this.firebaseAuth);
  
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if(user != null) {
        return UserModel.fromFirebaseUser(user);
      } else {
        throw ServerException('User tidak ditemukan');
      }
    } on FirebaseAuthException catch(e) {
      sl<Logger>().d("message ${e.message}");
      String handleFirebaseExc = ServerException.handleFirebaseException(e.code);
      throw ServerException(handleFirebaseExc);
    } catch(e) {
      sl<Logger>().d("catch ${e.toString()}");
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<UserModel> registrasi(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if(user != null) {
        return UserModel.fromFirebaseUser(user);
      } else {
        throw ServerException('User tidak ditemukan');
      }
    } on FirebaseAuthException catch(e) {
      sl<Logger>().d("message ${e.message}");
      final String handleFirebaseExc = ServerException.handleFirebaseException(e.code);
      throw ServerException(handleFirebaseExc);
    } catch(e) {
      sl<Logger>().d("catch ${e.toString()}");
      throw ServerException(e.toString());
    }
  }
}