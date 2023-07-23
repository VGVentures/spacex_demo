import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';
import 'package:spacex_demo/rockets/rockets.dart';

class RocketsPage extends StatelessWidget {
  const RocketsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const RocketsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RocketsCubit(
        rocketRepository: context.read<RocketRepository>(),
      )..fetchAllRockets(),
      child: const RocketsView(),
    );
  }
}

class RocketsView extends StatelessWidget {
  const RocketsView({super.key});

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
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = context.select((RocketsCubit cubit) => cubit.state.status);

    switch (status) {
      case RocketsStatus.initial:
        return const SizedBox(
          key: Key('rocketsView_initial_sizedBox'),
        );
      case RocketsStatus.loading:
        return const Center(
          key: Key('rocketsView_loading_indicator'),
          child: CircularProgressIndicator.adaptive(),
        );
      case RocketsStatus.failure:
        return Center(
          key: const Key('rocketsView_failure_text'),
          child: Text(l10n.rocketsFetchErrorMessage),
        );
      case RocketsStatus.success:
        return const _RocketList(
          key: Key('rocketsView_success_rocketList'),
        );
    }
  }
}

class _RocketList extends StatelessWidget {
  const _RocketList({super.key});

  @override
  Widget build(BuildContext context) {
    final rockets =
        context.select((RocketsCubit cubit) => cubit.state.rockets!);

    return ListView(
      children: [
        for (final rocket in rockets) ...[
          ListTile(
            isThreeLine: true,
            onTap: () {
              Navigator.of(context).push(
                RocketDetailsPage.route(rocket: rocket),
              );
            },
            title: Text(rocket.name),
            subtitle: Text(
              rocket.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right_sharp),
          ),
          const Divider(),
        ],
      ],
    );
  }
}
