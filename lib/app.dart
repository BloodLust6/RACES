import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:races/bindings/general_bindings.dart';
import 'package:races/routes/app_routes.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: SColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: SColors.white,
          ),
        ),
      ),
    );
  }
}
