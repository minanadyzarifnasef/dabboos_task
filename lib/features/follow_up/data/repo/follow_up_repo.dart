import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/base_repository.dart';
import '../models/follow_up.dart';
import '../models/follow_up_response.dart';
import '../datasources/follow_up_remote_data_source.dart';
import '../datasources/follow_up_local_data_source.dart';

// Interface (Abstraction)
abstract class FollowUpRepo {
  Future<ApiResult<FollowUpResponse>> getFollowUps();
  Future<ApiResult<FollowUp>> getFollowUpDetails(String id);
}

// Implementation
class FollowUpRepoImpl extends BaseRepository implements FollowUpRepo {
  final FollowUpRemoteDataSource _remoteDataSource;
  final FollowUpLocalDataSource _localDataSource;

  FollowUpRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<ApiResult<FollowUpResponse>> getFollowUps() async {
    // Try Remote First
    final result = await safeApiCall(() => _remoteDataSource.getFollowUps());

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) async {
        // Fallback to Local/Mock Data
        try {
          final mockData = await _localDataSource.getMockFollowUps();
          return ApiResult.success(mockData);
        } catch (e) {
          // If even local fails (unlikely for mock), return the original error or a new one
          return ApiResult.failure(error);
        }
      },
    );
  }

  @override
  Future<ApiResult<FollowUp>> getFollowUpDetails(String id) async {
    final result = await safeApiCall(() => _remoteDataSource.getFollowUpDetails(id));

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) async {
         try {
          final mockData = await _localDataSource.getFollowUpDetailsMock(id);
          return ApiResult.success(mockData);
        } catch (e) {
          return ApiResult.failure(error);
        }
      },
    );
  }
}
