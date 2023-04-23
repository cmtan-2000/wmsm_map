import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/routes.dart';
import 'package:wmsm_flutter/view/custom/themes/custom_theme.dart';
import 'viewmodel/user_view_model.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // // Keep Splash Screen until initialization has completed!
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(
  //     widgetsBinding:
  //         widgetsBinding); // FlutterNativeSplash.removeAfter(initialization);

  runApp(const MyApp());
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserViewModel())],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'My App',
        theme: customTheme,
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
