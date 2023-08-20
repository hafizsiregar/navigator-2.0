import 'package:declarative_navigation/provider/auth_provider.dart';
import 'package:declarative_navigation/routes/page_manager.dart';
import 'package:declarative_navigation/routes/router_delegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/auth_repository.dart';

void main() {
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

  @override
  void initState() {
    super.initState();
    final authRepository = AuthRepository();
    authProvider = AuthProvider(authRepository);
    myRouterDelegate = MyRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageManager()),
        ChangeNotifierProvider(create: (context) => authProvider),
      ],
      child: MaterialApp(
        title: 'Quotes App',
        //! Navigator 1.0
        // home: QuotesListScreen(
        //   quotes: quotes,
        // ),
        //! Navigator 2.0
        home: Router(
          routerDelegate: myRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
