import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/common/di/di.dart' as di;
import 'package:promina_task/presentation/app.dart';
import 'package:promina_task/presentation/blocs/simple_bloc_oberserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await di.init();

  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}
