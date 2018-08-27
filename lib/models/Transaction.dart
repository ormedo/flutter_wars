class Transaction<T> {
  final T result;
  Transaction({this.result});
}

class TransactionInProcess<T> extends Transaction<T> {}

class TransactionError<T> extends Transaction<T> {
  final String errorMessage;
  TransactionError( {this.errorMessage });
}

class TransactionSuccess<T> extends Transaction<T> {
  TransactionSuccess(T result) : super(result: result);
}

class TransactionEmpty extends Transaction {}