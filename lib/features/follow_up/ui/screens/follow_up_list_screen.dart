import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_dimens.dart';
import '../../../../core/theming/app_text_styles.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'app_title'.tr(),
          style: AppTextStyles.appBarTitle,
        ),
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
            padding: const EdgeInsets.fromLTRB(AppDimens.padding16, AppDimens.padding8, AppDimens.padding16, AppDimens.padding16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(AppDimens.radius12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'search_hint'.tr(),
                        hintStyle: TextStyle(color: AppColors.textLightGrey),
                        prefixIcon: Icon(Icons.search, color: AppColors.textLightGrey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.padding16, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.padding12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(AppDimens.radius12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
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
                          color: currentFilter != null ? AppColors.primary : AppColors.textBlack.withValues(alpha: 0.54),
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
                        Icon(Icons.error_outline, size: 48, color: AppColors.error),
                        const SizedBox(height: AppDimens.padding16),
                        Text(message, style: AppTextStyles.font14GreyRegular),
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
                        padding: const EdgeInsets.only(bottom: AppDimens.padding24),
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
            color: AppColors.textLightGrey,
          ),
          const SizedBox(height: AppDimens.padding16),
          Text(
            isSearchingOrFiltering ? 'no_match'.tr() : 'no_follow_ups'.tr(),
            style: AppTextStyles.font18BlackSemiBold,
          ),
          if (isSearchingOrFiltering)
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.padding8),
              child: Text(
                'adjust_filter'.tr(),
                style: AppTextStyles.font14GreyRegular,
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
