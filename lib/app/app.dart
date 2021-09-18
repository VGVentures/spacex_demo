import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/home/home.dart';
import 'package:spacex_demo/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required RocketRepository rocketRepository,
    required CrewMemberRepository crewMemberRepository,
  })  : _rocketRepository = rocketRepository,
        _crewMemberRepository = crewMemberRepository,
        super(key: key);

  final RocketRepository _rocketRepository;
  final CrewMemberRepository _crewMemberRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _rocketRepository),
        RepositoryProvider.value(value: _crewMemberRepository),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.black,
        dividerTheme: const DividerThemeData(
          indent: 16.0,
          space: 0.0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
