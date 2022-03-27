import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pubdates/common/themes.dart';
import 'package:pubdates/common/utils/path_utils.dart';
import 'package:pubdates/common/utils/url_utils.dart';
import 'package:pubdates/features/home/home_page.dart';
import 'package:pubdates/features/opened_projects/bloc/opened_projects_bloc.dart';
import 'package:pubdates/features/opened_projects/repositories/open_projects_repository.dart';
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
        RepositoryProvider<UrlOpener>(
          create: (_) => const UrlOpener(),
        ),
        RepositoryProvider<PathPicker>(
          create: (_) => const PathPicker(),
        ),
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
        RepositoryProvider(
          create: (context) => OpenProjectsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<OpenedProjectsBloc>(
            create: (context) => OpenedProjectsBloc(
              projectsRepository: context.read(),
            )..add(const OpenedProjectsEvent.loadAll()),
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
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute(builder: (_) => const HomePage());
          },
        ),
      ),
    );
  }
}
