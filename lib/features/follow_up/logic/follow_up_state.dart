import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/models/follow_up.dart';

part 'follow_up_state.freezed.dart';

@freezed
class FollowUpState with _$FollowUpState {
  const factory FollowUpState.initial() = _Initial;
  const factory FollowUpState.loading() = _Loading;
  const factory FollowUpState.success(
    List<FollowUp> followUps, {
    @Default('') String query,
    FollowUpStatus? filter,
  }) = _Success;
  const factory FollowUpState.error(String message) = _Error;
}
