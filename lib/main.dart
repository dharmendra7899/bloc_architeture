import 'package:counter_demo_bloc/multi_bloc.dart';
import 'package:counter_demo_bloc/theme/theme.dart';
import 'package:counter_demo_bloc/utils/routes/routes.dart';
import 'package:counter_demo_bloc/utils/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'dependency_injection_container.dart' as di;

final serviceLocator = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocWrapper(
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: AppTheme.lightThemeMode,
        darkTheme: AppTheme.darkThemeMode,
        locale: Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteNames.counter,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
