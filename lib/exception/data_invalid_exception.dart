class DataInvalidException {
  final String message;

  DataInvalidException(this.message);

  @override
  String toString() => 'DataInvalidException: $message';
  
}