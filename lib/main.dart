import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wts_customer/helping/app_translation.dart';
import 'package:wts_customer/routes.dart';
import 'package:wts_customer/util/my_shared_preparence.dart';
import 'package:wts_customer/view/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'helping/appStringFile.dart';


//
// flutter build apk --release --no-sound-null-safety
//
// flutter build apk --split-per-abi --no-sound-null-safety
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  //...........................fcm source...........................
  // https://github.com/Amanullahgit/FCM_Flutter-Notification
  String? lang = (await MySharedPreference.getLanguage());
  runApp(MyApp(lang: lang));
}

class MyApp extends StatelessWidget {
  String? lang;

  MyApp({this.lang});


  void fcmSubscribe() {
    FirebaseMessaging.instance.subscribeToTopic('customer');
    print(
        '..........................fcmSubscribe...............................');
  }

  void fcmUnSubscribe() {
    FirebaseMessaging.instance.unsubscribeFromTopic('customer');
    print(
        '..........................unsubscribeFromTopic...............................');
  }

  @override
  Widget build(BuildContext context) {
    fcmSubscribe();
    return GetMaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.blue, canvasColor: Colors.white),
      debugShowCheckedModeBanner: false,
      title: AppStringKey.app_name,
      translations: AppTranslation(),
      locale: lang == 'bn' ? Locale('bn', 'BD') : Locale('en', 'US'),
      // Get.locale
      fallbackLocale: Locale('en', 'US'),
      initialRoute: SplashScreen.pageId,
      getPages: appPages,
    );
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({required this.title}) : super();
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   getToken() async {
//     String? token = await FirebaseMessaging.instance.getToken();
//     print('.......................................token=${token}.....');
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getToken();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channel.description,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher',
//               ),
//             ));
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null) {
//         showDialog(
//             context: context,
//             builder: (_) {
//               return AlertDialog(
//                 title: Text(notification?.title ?? ''),
//                 content: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [Text(notification?.body ?? '')],
//                   ),
//                 ),
//               );
//             });
//       }
//     });
//   }
//
//   void showNotification() {
//     setState(() {
//       _counter++;
//     });
//     flutterLocalNotificationsPlugin.show(
//         0,
//         "Testing $_counter",
//         "How you doin ?",
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//                 channel.id, channel.name, channel.description,
//                 importance: Importance.high,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher')));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showNotification,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }




//
//
// import 'package:flutter/material.dart';
// import 'file:///F:/practice-app/flutter_practice_app/lib/view/screen/splash_screen.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SplashScreen(),
//     );
//   }
// }
//
