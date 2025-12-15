import 'package:uuid/uuid.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../../../../core/networking/base_repository.dart';
import '../models/follow_up.dart';
import '../models/follow_up_response.dart';

class FollowUpRepo extends BaseRepository {
  final ApiService _apiService;
  final _uuid = const Uuid();

  FollowUpRepo(this._apiService);

  Future<ApiResult<FollowUpResponse>> getFollowUps() async {
    final result = await safeApiCall(() => _apiService.getFollowUps());

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) {
        // Fallback to mock data on error
        return ApiResult.success(_getMockResponse());
      },
    );
  }

  FollowUpResponse _getMockResponse() {
    return FollowUpResponse(
      status: true,
      message: 'Mock Data',
      followUps: [
        FollowUp(
          id: _uuid.v4(),
          title: 'Contract Renewal',
          description:
              '<p>Discuss the <b>contract terms</b> for the upcoming year.</p>',
          type: FollowUpType.meeting,
          status: FollowUpStatus.scheduled,
          customerName: 'Acme Corp',
          scheduledDate: DateTime.now().add(const Duration(days: 2)),
        ),
        FollowUp(
          id: _uuid.v4(),
          title: 'Initial Consultation',
          description: 'Client is interested in the <i>premium</i> package.',
          type: FollowUpType.call,
          status: FollowUpStatus.completed,
          customerName: 'John Doe',
          scheduledDate: DateTime.now().subtract(const Duration(days: 1)),
        ),
        FollowUp(
          id: _uuid.v4(),
          title: 'On-site Inspection',
          description: 'Inspect the server room cooling system.',
          type: FollowUpType.visit,
          status: FollowUpStatus.noStatus,
          customerName: 'TechSolutions Inc.',
          scheduledDate: DateTime.now().add(const Duration(days: 5)),
        ),
        FollowUp(
          id: _uuid.v4(),
          title: 'Feasibility Study Update',
          description: 'Review the latest <u>feasibility report</u> numbers.',
          type: FollowUpType.meeting,
          status: FollowUpStatus.scheduled,
          customerName: 'Global Ventures',
        ),
        FollowUp(
          id: _uuid.v4(),
          title: 'Cold Call',
          description: 'Introduce our new cloud services.',
          type: FollowUpType.call,
          status: FollowUpStatus.noStatus,
          customerName: 'StartUp Hub',
        ),
        FollowUp(
          id: _uuid.v4(),
          title: 'Quarterly Review',
          description: 'Go over Q3 performance metrics.',
          type: FollowUpType.meeting,
          status: FollowUpStatus.completed,
          customerName: 'Enterprise Ltd',
        ),
        FollowUp(
          id: _uuid.v4(),
          title: 'Urgent Fix',
          description: 'Client reported downtime on the main dashboard.',
          type: FollowUpType.call,
          status: FollowUpStatus.noStatus,
          customerName: 'Acme Corp',
        ),
      ],
    );
  }
}
