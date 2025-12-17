import '../../../../core/networking/api_service.dart';
import '../models/follow_up.dart';
import '../models/follow_up_response.dart';

class FollowUpRemoteDataSource {
  final ApiService _apiService;

  FollowUpRemoteDataSource(this._apiService);

  Future<FollowUpResponse> getFollowUps() async {
    return await _apiService.getFollowUps();
  }

  Future<FollowUp> getFollowUpDetails(String id) async {
    return await _apiService.getFollowUpDetails(id);
  }
}
