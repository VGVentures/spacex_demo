import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';
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
        child: _LaunchesContent(),
      ),
    );
  }
}

class _LaunchesContent extends StatelessWidget {
  const _LaunchesContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.select((LaunchesCubit cubit) => cubit.state);

    switch (state.status) {
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
        return _LatestLaunch(
          key: const Key('launchesView_success_latestLaunch'),
          latestLaunch: state.latestLaunch!,
        );
    }
  }
}

class _LatestLaunch extends StatelessWidget {
  const _LatestLaunch({Key? key, required this.latestLaunch}) : super(key: key);

  final Launch latestLaunch;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
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
                      Text(latestLaunch.name),
                      Text('${latestLaunch.flightNumber}'),
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
            key: const Key('launchesPage_link_buttons'),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
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
              Align(
                alignment: Alignment.bottomCenter,
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
