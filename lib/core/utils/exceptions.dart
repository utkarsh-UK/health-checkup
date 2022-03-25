class ServerException implements Exception {
  final String message;

  ServerException({
    this.message = 'Could not process your request at the moment',
  });
}
