import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pubdates/features/home/home_page.dart';
import 'package:pubdates/features/project/repositories/project_repository.dart';
import 'package:pubdates/features/project/services/pubspec_reader.dart';
import 'package:pubdates/features/project/services/package_service.dart';
import 'package:pubdates/localization/app_localizations.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PubspecReader>(
          create: (context) => const DefaultPubspecReader(),
        ),
        RepositoryProvider<PackageService>(
          create: (context) => const DefaultPackageService(),
        ),
        RepositoryProvider<ProjectRepository>(
          create: (context) => DefaultProjectRepository(
            pubspecService: context.read(),
            packageUpdater: context.read(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
        theme: ThemeData.light().copyWith(useMaterial3: true),
        darkTheme: ThemeData.dark().copyWith(useMaterial3: true),
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(builder: (_) => const HomePage());
        },
      ),
    );
  }
}
