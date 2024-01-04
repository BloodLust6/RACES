import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:races/app.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/firebase_options.dart';

void main() async {
  // Widget binding
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // Get storage
  await GetStorage.init();

  // Await splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize firebase & authentication repo
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  await FirebaseAppCheck.instance.activate();

  // Load all the material design
  runApp(const App());
}
