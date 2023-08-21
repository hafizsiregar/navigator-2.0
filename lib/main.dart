import 'package:declarative_navigation/provider/auth_provider.dart';
import 'package:declarative_navigation/routes/page_manager.dart';
import 'package:declarative_navigation/routes/route_information_parser.dart';
import 'package:declarative_navigation/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/url_strategy.dart';
import 'db/auth_repository.dart';

void main() {
  usePathUrlStrategy();
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  late MyRouterDelegate myRouterDelegate;
  late AuthProvider authProvider;
  late MyRouteInformationParser myRouteInformationParser;

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    authProvider = AuthProvider(authRepository);
    myRouterDelegate = MyRouterDelegate(authRepository);
    myRouteInformationParser = MyRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageManager()),
        ChangeNotifierProvider(create: (context) => authProvider),
      ],
      //! Navigator mobile
      // child: MaterialApp(
      //   title: 'Quotes App',
      //   //! Navigator 1.0
      //   // home: QuotesListScreen(
      //   //   quotes: quotes,
      //   // ),
      //   //! Navigator 2.0
      //   home: Router(
      //     routerDelegate: myRouterDelegate,
      //     backButtonDispatcher: RootBackButtonDispatcher(),
      //   ),
      // ),
      //! Navigator web
      child: MaterialApp.router(
        title: 'Quotes App',
        routerDelegate: myRouterDelegate,
        backButtonDispatcher: RootBackButtonDispatcher(),
        routeInformationParser: myRouteInformationParser,
      ),
    );
  }
}
