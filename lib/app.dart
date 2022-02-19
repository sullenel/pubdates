import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pubdates/features/home/home_page.dart';
import 'package:pubdates/features/project/repositories/project_repository.dart';
import 'package:pubdates/features/project/services/pubspec_service.dart';
import 'package:pubdates/localization/app_localizations.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PubspecService>(
          create: (context) => const DefaultPubspecService(),
        ),
        RepositoryProvider<ProjectRepository>(
          create: (context) => DefaultProjectRepository(
            pubspecService: context.read(),
          ),
        ),
      ],
      child: MaterialApp(
        restorationScopeId: 'app',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
        ],
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context).appTitle,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(builder: (_) => const HomePage());
        },
      ),
    );
  }
}
