import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/follow_up.dart';

part 'follow_up_details_state.freezed.dart';

@freezed
class FollowUpDetailsState with _$FollowUpDetailsState {
  const factory FollowUpDetailsState.initial() = _Initial;
  const factory FollowUpDetailsState.loading() = _Loading;
  const factory FollowUpDetailsState.success(FollowUp followUp) = _Success;
  const factory FollowUpDetailsState.error(String message) = _Error;
}
