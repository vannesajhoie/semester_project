import 'package:flutter/material.dart';
import 'constants/app_constants.dart';
import 'routes/app_routes.dart';

class ParkKeysApp extends StatelessWidget {
  const ParkKeysApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Park Keys',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kBg,
          colorScheme: const ColorScheme.dark(primary: kGreen),
          appBarTheme: const AppBarTheme(backgroundColor: kBg, elevation: 0),
        ),
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generate,
      );
}