import 'package:uuid/uuid.dart';
import '../../../../core/networking/api_result.dart'; // Just in case
import '../models/follow_up.dart';
import '../models/follow_up_response.dart';

class FollowUpLocalDataSource {
  final _uuid = const Uuid();

  Future<FollowUpResponse> getMockFollowUps() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    return FollowUpResponse(
      status: true,
      message: 'Mock Data (Offline/Fallback)',
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

  Future<FollowUp> getFollowUpDetailsMock(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // In a real local source, you would query DB. Here we return a dummy specific one 
    // or search the list if we stored it variable.
    // For simplicity, let's return a detailed mock.
    return FollowUp(
      id: id,
      title: 'Detailed Mock Follow Up',
      description: 'This is the detailed description fetched from local mock source.',
      type: FollowUpType.meeting,
      status: FollowUpStatus.scheduled,
      customerName: 'Mock Customer',
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
    );
  }
}
