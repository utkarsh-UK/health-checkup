/// Custom class to catch ServerExceptions.
/// 
/// [message] field provides reason of the exception in short.
class ServerException implements Exception {
  final String message;

  ServerException({
    this.message = 'Could not process your request at the moment.',
  });
}
