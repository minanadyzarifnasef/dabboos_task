import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../logic/follow_up_cubit.dart';
import '../../logic/follow_up_state.dart';
import '../widgets/follow_up_card.dart';
import '../widgets/filter_modal.dart';
import '../../data/models/follow_up.dart';
import '../widgets/follow_up_list_shimmer.dart';

class FollowUpListScreen extends StatefulWidget {
  const FollowUpListScreen({super.key});

  @override
  State<FollowUpListScreen> createState() => _FollowUpListScreenState();
}

class _FollowUpListScreenState extends State<FollowUpListScreen> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<FollowUpCubit>().search(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('app_title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar', 'EG'));
              } else {
                context.setLocale(const Locale('en', 'US'));
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'search_hint'.tr(),
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: BlocBuilder<FollowUpCubit, FollowUpState>(
                    builder: (context, state) {
                      final currentFilter = state.maybeWhen(
                        success: (_, __, filter) => filter,
                        orElse: () => null,
                      );
                      
                      return IconButton(
                        icon: Icon(
                          Icons.filter_list_rounded,
                          color: currentFilter != null ? Colors.deepPurple : Colors.black54,
                        ),
                        onPressed: () => _showFilterModal(context, currentFilter),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<FollowUpCubit, FollowUpState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () => const FollowUpListShimmer(),
                  error: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
                        const SizedBox(height: 16),
                        Text(message),
                        TextButton(
                          onPressed: () => context.read<FollowUpCubit>().fetchFollowUps(),
                          child: Text('retry'.tr()),
                        ),
                      ],
                    ),
                  ),
                  success: (followUps, query, filter) {
                    if (followUps.isEmpty) {
                      return _buildEmptyState(query.isNotEmpty || filter != null);
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                         context.read<FollowUpCubit>().fetchFollowUps();
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: followUps.length,
                        itemBuilder: (context, index) {
                          return FollowUpCard(followUp: followUps[index]);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isSearchingOrFiltering) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSearchingOrFiltering ? Icons.search_off_rounded : Icons.assignment_turned_in_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            isSearchingOrFiltering ? 'no_match'.tr() : 'no_follow_ups'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          if (isSearchingOrFiltering)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'adjust_filter'.tr(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  void _showFilterModal(BuildContext context, FollowUpStatus? currentFilter) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterModal(
        currentFilter: currentFilter,
        onFilterSelected: (status) {
          context.read<FollowUpCubit>().updateFilter(status);
        },
      ),
    );
  }
}
