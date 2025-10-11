import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workiom_test/presentation/bloc/auth/auth_bloc.dart';
import 'package:workiom_test/presentation/bloc/edition/edition_bloc.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/utils/bloc_observer.dart';
import 'presentation/resources/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const WorkiomApp());
}

class WorkiomApp extends StatelessWidget {
  const WorkiomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
          getIt<AuthBloc>()
            ..add(CheckLoginStatus()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => getIt<EditionBloc>()..add(LoadEditions()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Workiom',
            debugShowCheckedModeBanner: false,
            theme: ThemeManager.lightTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
