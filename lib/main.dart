
import 'package:conditional_questions/conditional_questions.dart';
import 'package:echoes_of_equality/firebase_options.dart';
import 'package:echoes_of_equality/pages/login_pages/auth_gate.dart';
import 'package:echoes_of_equality/pages/login_pages/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:echoes_of_equality/pages/onboarding_screen.dart';
bool showHome = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final prefs = await SharedPreferences.getInstance();
  // Update this line, remove the bool keyword to modify the global variable
  showHome = prefs.getBool('showHome') ?? true;
  runApp(ChangeNotifierProvider(create: (context) => AuthService(),
    child: MyApp(),)
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: showHome? const OnBoardingScreen() : const AuthGate(),
    );
  }
}

