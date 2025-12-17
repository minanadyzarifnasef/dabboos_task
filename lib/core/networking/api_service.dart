import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/follow_up/data/models/follow_up.dart';
import '../../features/follow_up/data/models/follow_up_response.dart';
import 'api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET(ApiConstants.getFollowUpsList)
  Future<FollowUpResponse> getFollowUps();

  @GET(ApiConstants.getFollowUpDetails)
  Future<FollowUp> getFollowUpDetails(@Path('id') String id);


}
