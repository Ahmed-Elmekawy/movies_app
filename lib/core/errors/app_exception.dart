abstract class AppException implements Exception {
  String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class RemoteException extends AppException {
  RemoteException(super.message);
}
