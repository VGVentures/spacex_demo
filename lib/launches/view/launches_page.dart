import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/launches/cubit/launches_cubit.dart';

class LaunchesPage extends StatelessWidget {
  const LaunchesPage({Key? key}) : super(key: key);

  static Route<LaunchesPage> route() {
    return MaterialPageRoute(
      builder: (context) => const LaunchesPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaunchesCubit(
        launchRepository: context.read<LaunchRepository>(),
      )..fetchLatestLaunch(),
      child: const LaunchesView(),
    );
  }
}

class LaunchesView extends StatelessWidget {
  const LaunchesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.rocketsAppBarTitle),
      ),
      body: const Center(
        child: _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = context.select((LaunchesCubit cubit) => cubit.state.status);

    switch (status) {
      case LaunchesStatus.initial:
        return const SizedBox(
          key: Key('launchesView_initial_sizedBox'),
        );
      case LaunchesStatus.loading:
        return const Center(
          key: Key('launchesView_loading_indicator'),
          child: CircularProgressIndicator.adaptive(),
        );
      case LaunchesStatus.failure:
        return Center(
          key: const Key('launchesView_failure_text'),
          child: Text(l10n.rocketsFetchErrorMessage),
        );
      case LaunchesStatus.success:
        return const _LatestLaunch(
          key: Key('launchesView_success_rocketList'),
        );
    }
  }
}

class _LatestLaunch extends StatelessWidget {
  const _LatestLaunch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final latestLaunch =
        context.select((LaunchesCubit cubit) => cubit.state.latestLaunch!);

    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(latestLaunch.name),
            Text('${latestLaunch.flightNumber}'),
          ],
        ));
  }
}
