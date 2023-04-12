import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:promina_task/common/di/di.dart';

import '../common/resources/routes_manager.dart';
import '../common/resources/theme_manager.dart';
import 'blocs/auth/auth_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocProvider(
          create: (context) => instance<AuthBloc>(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.loginRoute,
            onGenerateRoute: RoutesGenerator.getRoute,
            theme: getAppTheme(),
          ),
        );
      },
    );
  }
}
