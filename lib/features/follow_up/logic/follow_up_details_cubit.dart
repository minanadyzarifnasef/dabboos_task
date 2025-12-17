import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/networking/api_result.dart';
import '../data/repo/follow_up_repo.dart';
import 'follow_up_details_state.dart';

class FollowUpDetailsCubit extends Cubit<FollowUpDetailsState> {
  final FollowUpRepo _repo;

  FollowUpDetailsCubit(this._repo) : super(const FollowUpDetailsState.initial());

  void getFollowUpDetails(String id) async {
    emit(const FollowUpDetailsState.loading());

    final result = await _repo.getFollowUpDetails(id);

    result.when(
      success: (followUp) {
        emit(FollowUpDetailsState.success(followUp));
      },
      failure: (error) {
        emit(FollowUpDetailsState.error(error.getUserFriendlyMessage()));
      },
    );
  }
}
