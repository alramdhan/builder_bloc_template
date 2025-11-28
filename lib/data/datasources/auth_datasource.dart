import 'package:builder_bloc_template/core/config/error/exception.dart';
import 'package:builder_bloc_template/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        throw ServerException(Exception('User tidak ditemukan'));
      }
    } on FirebaseAuthException catch(e) {
      print("emsg ${e.message}");
      throw ServerException(Exception(e));
    } catch(e) {
      throw ServerException(Exception(e));
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
        throw ServerException(Exception('User tidak ditemukan'));
      }
    } on FirebaseAuthException catch(e) {
      print("emsg ${e.message}");
      throw ServerException(e);
    } catch(e) {
      throw ServerException(Exception(e));
    }
  }
}