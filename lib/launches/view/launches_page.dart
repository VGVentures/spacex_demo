import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/launches/cubit/launches_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

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
        title: Text(l10n.latestLaunchAppBarTitle),
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
    final l10n = context.l10n;

    final latestLaunch =
        context.select((LaunchesCubit cubit) => cubit.state.latestLaunch!);

    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          //Latest Launch Row, following widget could be a list of launches
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(latestLaunch.links.patch.small),
                  radius: 50,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          // const Text('Name: '),
                          Text(latestLaunch.name),
                        ],
                      ),
                      Row(
                        children: [
                          // const Text('Flight Number:'),
                          Text('${latestLaunch.flightNumber}'),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            subtitle: latestLaunch.dateUtc == null
                ? null
                : Text(
                    l10n.latestLaunchSubtitle(
                      DateFormat('dd-MM-yyyy hh:mm')
                          .format(latestLaunch.dateUtc!),
                    ),
                  ),
          ),
          const SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Positioned(
                left: 16,
                bottom: 16,
                right: 16,
                child: SizedBox(
                  height: 64,
                  child: ElevatedButton(
                    key: const Key(
                      'launchesPage_openWebcast_elevatedButton',
                    ),
                    onPressed: () async {
                      final url = latestLaunch.links.webcast;

                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    child: Text(l10n.openWebcastButtonText),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                right: 16,
                child: SizedBox(
                  height: 64,
                  child: ElevatedButton(
                    key: const Key(
                      'launchesPage_openWikipedia_elevatedButton',
                    ),
                    onPressed: () async {
                      final url = latestLaunch.links.wikipedia;

                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    child: Text(l10n.openWikipediaButtonText),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
