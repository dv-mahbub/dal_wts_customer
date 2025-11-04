import 'package:get/get.dart';
import 'package:wts_customer/binding/auth_screen_binding.dart';
import 'package:wts_customer/binding/home_page_binding.dart';
import 'package:wts_customer/view/screen/add_complain_screen.dart';
import 'package:wts_customer/view/screen/complain_creation_result_screen.dart';
import 'package:wts_customer/view/screen/complain_details_screen.dart';
import 'package:wts_customer/view/screen/complain_notcompleted_screen.dart';
import 'package:wts_customer/view/screen/feedback_screen.dart';
import 'package:wts_customer/view/screen/home_page.dart';
import 'package:wts_customer/view/screen/product_details_screen.dart';
import 'package:wts_customer/view/screen/login_screen.dart';
import 'package:wts_customer/view/screen/onboarding_screen.dart';
import 'package:wts_customer/view/screen/splash_screen.dart';

final List<GetPage> appPages = [
  GetPage(
    name: SplashScreen.pageId,
    page: () => SplashScreen(),
  ),
  GetPage(
      name: OnBoardingScreen.pageId,
      page: () => OnBoardingScreen(),
      // binding: LoginScreenBinding(),
      transition: Transition.upToDown),

  GetPage(
      name: LoginScreen.pageId,
      page: () => LoginScreen(),
      binding: AuthScreenBinding(),
      transition: Transition.upToDown),
  GetPage(
      name: HomePage.pageId,
      page: () => HomePage(),
      binding: HomePageBinding(),
      transition: Transition.upToDown),
  GetPage(
      name: AddComplainScreen.pageId,
      page: () => AddComplainScreen(),
    //  binding: HomePageBinding(),
      transition: Transition.upToDown),
  GetPage(
      name: ComplainCreationResultScreen.pageId,
      page: () => ComplainCreationResultScreen(),
   //   binding: HomePageBinding(),
      transition: Transition.upToDown),

  GetPage(
      name: ComplainDetailsScreen.pageId,
      page: () => ComplainDetailsScreen(),
      binding: HomePageBinding(),
      transition: Transition.upToDown),

  GetPage(
      name: FeedBackScreen.pageId,
      page: () => FeedBackScreen(),
      binding: HomePageBinding(),
      transition: Transition.cupertino),
  GetPage(
      name: ComplainNotCompletedScreen.pageId,
      page: () => ComplainNotCompletedScreen(),
      binding: HomePageBinding(),
      transition: Transition.cupertino),
  // GetPage(
  //     name: InstallationCheckListScreen.pageId,
  //     page: () => InstallationCheckListScreen(),
  //     binding: HomePageBinding(),
  //     transition: Transition.cupertino),
  // GetPage(
  //     name: HomeScreen.pageId,
  //     page: () => HomeScreen(),
  //     //  binding: HomeScreenBinding(),
  //     transition: Transition.upToDown),
  // GetPage(
  //     name: ComplainScreen.pageId,
  //     page: () => ComplainScreen(),
  //     //  binding: HomeScreenBinding(),
  //     transition: Transition.upToDown),
];
