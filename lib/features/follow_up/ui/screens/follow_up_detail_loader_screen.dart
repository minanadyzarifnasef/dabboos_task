import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:task/core/di/dependency_injection.dart';
import '../../data/models/follow_up.dart';
import '../../logic/follow_up_details_cubit.dart';
import '../../logic/follow_up_details_state.dart';
import 'follow_up_detail_screen.dart';

class FollowUpDetailLoaderScreen extends StatelessWidget {
  final FollowUp followUp;

  const FollowUpDetailLoaderScreen({super.key, required this.followUp});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FollowUpDetailsCubit>()..getFollowUpDetails(followUp.id),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: BlocConsumer<FollowUpDetailsCubit, FollowUpDetailsState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (msg) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(msg), backgroundColor: Colors.red),
                );
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              success: (details) => FollowUpDetailScreen(followUp: details),
              error: (msg) => _buildErrorState(context, msg),
              orElse: () => _buildLoadingState(),
            );
          },
        ),
      ),
    );
  }

  // Show the initial passed data while loading detailed data?
  // Or just show a loader?
  // Let's show a loading overlay on top of the basic details if possible, 
  // OR just a nice skeleton loader. 
  // Given the "premium" requirement, let's show a skeleton or just the screen with a loading indicator.
  
  Widget _buildLoadingState() {
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const CircularProgressIndicator(),
           const SizedBox(height: 16),
           Text(
             'loading_details'.tr(),
             style: GoogleFonts.inter(color: Colors.grey.shade600),
           ),
         ],
       ),
     );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(message),
          TextButton(
            onPressed: () {
               context.read<FollowUpDetailsCubit>().getFollowUpDetails(followUp.id);
            },
            child: Text('retry'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context), // Go back
            child: Text('go_back'.tr()),
          ),
        ],
      ),
    );
  }
}
