import 'package:flutter/material.dart';
import '../../core/networking/dio_factory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/networking/api_service.dart';
import 'features/follow_up/data/repo/follow_up_repo.dart';
import 'features/follow_up/logic/follow_up_cubit.dart';
import 'features/follow_up/ui/screens/follow_up_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioFactory.getDio(); // Initialize Dio
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final apiService = ApiService(DioFactory.dio!);
            final repo = FollowUpRepo(apiService);
            return FollowUpCubit(repo)..fetchFollowUps();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Follow-Up Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6750A4),
            brightness: Brightness.light,
            surface: const Color(0xFFF8F9FA),
          ),
          textTheme: GoogleFonts.interTextTheme(),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            titleTextStyle: GoogleFonts.inter(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: const IconThemeData(color: Colors.black87),
          ),
        ),
        home: const FollowUpListScreen(),
      ),
    );
  }
}
