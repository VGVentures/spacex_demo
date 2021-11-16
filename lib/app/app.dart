import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/home/home.dart';
import 'package:spacex_demo/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required RocketRepository rocketRepository,
    required CrewMemberRepository crewMemberRepository,
    required LaunchRepository launchRepository,
  })  : _rocketRepository = rocketRepository,
        _crewMemberRepository = crewMemberRepository,
        _launchRepository = launchRepository,
        super(key: key);

  final RocketRepository _rocketRepository;
  final CrewMemberRepository _crewMemberRepository;
  final LaunchRepository _launchRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _rocketRepository),
        RepositoryProvider.value(value: _crewMemberRepository),
        RepositoryProvider.value(value: _launchRepository)
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          secondary: Colors.white,
        ),
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        dividerTheme: const DividerThemeData(
          indent: 16,
          space: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
