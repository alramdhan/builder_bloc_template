class ServerException implements Exception {
  Exception e;

  ServerException(this.e);
}