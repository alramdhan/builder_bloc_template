class ServerException {
  String message;

  ServerException(this.message);

  static String handleFirebaseException(code) {
    String errorMessage = "";
    switch(code) {
      case 'invalid-credential':
        errorMessage = "Email atau Password salah.";
        break;
      case 'email-already-in-use':
        errorMessage = 'Alamat email ini sudah terdaftar.';
        break;
      default:
        errorMessage = 'Terjadi kesalahan';
        break;
    }

    return errorMessage;
  }
}