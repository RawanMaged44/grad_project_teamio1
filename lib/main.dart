import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/tasks_screen/presentation/view/screens/tasks_screen.dart';
import 'core/api/dio_helper.dart';
import 'core/functions/storage_helper.dart';
import 'core/utils/app_routes.dart';
import 'features/chat_screen/data/repo/chat_repo_impl.dart';
import 'features/chat_screen/presentation/controller/chat_cbit/chat_cubit.dart';
import 'features/chat_screen/presentation/view/screens/chat_screen.dart';
import 'features/homeScreen/presentation/controller/home_cubit.dart';
import 'features/homeScreen/data/repo/home_repo_impl.dart';
import 'features/homeScreen/presentation/view/screen/home_screen.dart';
import 'features/login_screen/presentation/controller/login_cubit.dart';
import 'features/login_screen/data/repo/login_rebo_impl.dart';
import 'features/login_screen/presentation/view/screen/login_screen.dart';
import 'features/profile_screen/data/repo/profile_repo_impl.dart';
import 'features/profile_screen/presentation/controller/profile_cubit/profile_cubit.dart';
import 'features/tasks_screen/data/repo/task_repo_impl.dart';
import 'features/tasks_screen/presentation/controller/task_cubit/task_cubit.dart';
import 'features/update_profile_screen/data/repo/update_profile_repo_impl.dart';
import 'features/update_profile_screen/presentation/controller/update_profile_cubit/update_profile_cubit.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Status bar transparent with white icons to match the dark background
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  final loginRepo = LoginRepoImpl(DioHelper.dio);
  DioHelper.init(loginRepo, navigatorKey: navigatorKey);

  final homeRepo = HomeRepoImpl(dio: DioHelper.dio);
  final taskRepo = TaskRepoImpl(DioHelper.dio);
  final profileRepo = ProfileRepoImpl(DioHelper.dio);
  final updateProfileRepo = UpdateProfileRepoImpl(DioHelper.dio);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(loginRepo)),
        BlocProvider(create: (context) => HomeCubit(homeRepo: homeRepo)),
        BlocProvider(create: (context) => ChatCubit(chatRepo: ChatRepoImpl(DioHelper.dio))),
        BlocProvider(create: (context) => TaskCubit(taskRepo)),
        BlocProvider(create: (context) => ProfileCubit(profileRepo)),
        BlocProvider(create: (context) => UpdateProfileCubit(updateProfileRepo)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _initialRoute = LoginScreen.routeName;
  String? _userName;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _resolveInitialRoute();
  }

  Future<void> _resolveInitialRoute() async {
    final token = await StorageHelper.getAccessToken();
    final userName = await StorageHelper.getUserName();
    setState(() {
      _initialRoute = (token != null && token.isNotEmpty)
          ? HomeScreen.routeName
          : LoginScreen.routeName;
      _userName = userName;
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a blank screen while resolving — avoids any flash
    if (!_ready) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(backgroundColor: Colors.black),
      );
    }

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: _initialRoute,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
          ),
        ),
        onGenerateRoute: (settings) {
          if (settings.name == HomeScreen.routeName) {
            final name = settings.arguments as String? ?? _userName ?? 'User';
            return MaterialPageRoute(
              builder: (context) => HomeScreen(userName: name),
            );
          }
          return null;
        },
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          ChatScreen.routeName: (context) => const ChatScreen(),
          TasksScreen.routeName: (context) => const TasksScreen(),
        },
      ),
    );
  }
}
