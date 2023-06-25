import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wmsm_flutter/routes.dart';
import 'package:wmsm_flutter/view/custom/themes/custom_theme.dart';
import 'package:wmsm_flutter/view/user_article/article_page.dart';
import 'package:wmsm_flutter/viewmodel/article_view/article_view_model.dart';
import 'package:wmsm_flutter/viewmodel/health_conn_view/health_conn_view_model.dart';
import 'package:wmsm_flutter/viewmodel/provider/example-changenotifier.dart';
import 'package:wmsm_flutter/viewmodel/provider/example-futureprovider.dart';
import 'view/health_conn/healthPage.dart';
import 'viewmodel/provider/example-streamprovider.dart';
import 'viewmodel/user_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  // // Keep Splash Screen until initialization has completed!
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(
  //     widgetsBinding:
  //         widgetsBinding); // FlutterNativeSplash.removeAfter(initialization);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseApi().initNotifications();
  runApp(const MyApp());
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(
          create: (_) => HealthConnViewModel(),
          child: const HeahthPage(),
        ),
        ChangeNotifierProvider(
          create: (_) => ArticleViewModel(),
          child: const ArticlePage(),
        ),
        ChangeNotifierProvider(
          create: (_) => ArticleViewModel(),
          child: const ArticlePage(),
        ),
        // ====================================================================
        // Example all Provider here
        ChangeNotifierProvider(create: (_) => MessageViewModel()),
        FutureProvider<List<dynamic>>(
          create: (_) => FutureViewModel().getFutureList(),
          initialData: const ['Loading Data 1', 0, false],
        ),
        StreamProvider<String>(
          create: (_) => StreamViewModel().fetchData1(),
          initialData: "Data1 from Empty",
        ),
        StreamProvider<int>(
          create: (_) => StreamViewModel().fetchNumber(),
          initialData: 0,
        ),
        ProxyProvider<MessageViewModel, bool>(
          update: (_, message, __) => message.value == '' ? false : true,
        ),
        // ====================================================================
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'My App',
        theme: customTheme,
        initialRoute: '/',
        // routes: routes,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
