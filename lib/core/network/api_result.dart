import 'package:multiple_result/multiple_result.dart';

class ApiResult<T> {
  final Result<T, String> result;
  
  ApiResult.success(T data) : result = Success(data);
  ApiResult.failure(String error) : result = Error(error);
  
  bool get isSuccess => result.isSuccess();
  bool get isFailure => result.isError();
  
  T? get data => result.when(
    (data) => data,
    (error) => null,
  );
  
  String? get error => result.when(
    (data) => null,
    (error) => error,
  );
  
  R when<R>({
    required R Function(T data) success,
    required R Function(String error) failure,
  }) {
    return result.when(success, failure);
  }
}
