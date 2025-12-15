import '../networking/api_constants.dart';

class AppUtilities {
  // Singleton pattern stub
  static final AppUtilities _instance = AppUtilities._internal();
  factory AppUtilities() => _instance;
  AppUtilities._internal();




  Future<String> getUniqueDeviceId() async {
    return 'unique-device-id-123'; 
  }


}
