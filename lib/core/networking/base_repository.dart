import '../models/error_model.dart';
import 'api_result.dart';

abstract class BaseRepository {
  Future<ApiResult<T>> safeApiCall<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return ApiResult.success(response);
    } catch (e) {
      // In a real app, you'd parse DioError here to get a user-friendly message
      return ApiResult.failure(ApiErrorModel(message: e.toString()));
    }
  }
}
