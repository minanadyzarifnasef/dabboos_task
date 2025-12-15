import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/networking/api_result.dart';
import '../data/models/follow_up.dart';
import '../data/repo/follow_up_repo.dart';
import 'follow_up_state.dart';

class FollowUpCubit extends Cubit<FollowUpState> {
  final FollowUpRepo _followUpRepo;
  List<FollowUp> _allFollowUps = [];
  String _currentQuery = '';
  FollowUpStatus? _currentFilter;

  FollowUpCubit(this._followUpRepo) : super(const FollowUpState.initial());

  void fetchFollowUps() async {
    emit(const FollowUpState.loading());
    
    final result = await _followUpRepo.getFollowUps();
    
    result.when(
      success: (response) {
        _allFollowUps = response.followUps ?? [];
        _applyFilters();
      },
      failure: (error) {
        emit(FollowUpState.error(error.getUserFriendlyMessage()));
      },
    );
  }

  void search(String query) {
    _currentQuery = query;
    _applyFilters();
  }

  void updateFilter(FollowUpStatus? status) {
    _currentFilter = status;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _allFollowUps;

    // Apply Search
    if (_currentQuery.isNotEmpty) {
      final q = _currentQuery.toLowerCase();
      filtered = filtered.where((followUp) {
        return followUp.title.toLowerCase().contains(q) ||
            (followUp.customerName?.toLowerCase().contains(q) ?? false);
      }).toList();
    }

    // Apply Filter
    if (_currentFilter != null) {
      filtered = filtered.where((f) => f.status == _currentFilter).toList();
    }

    emit(FollowUpState.success(
      filtered,
      query: _currentQuery,
      filter: _currentFilter,
    ));
  }
}
