abstract class AppException implements Exception{
  String message;
  AppException(this.message);
}


class RemoteException extends AppException{
  RemoteException(super.message);

}