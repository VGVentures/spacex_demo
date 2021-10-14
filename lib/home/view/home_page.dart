import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/home/home.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        rocketRepository: context.read<RocketRepository>(),
      )..fetchAllRockets(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
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
    final status = context.select((HomeCubit cubit) => cubit.state.status);

    switch (status) {
      case HomeStatus.initial:
        return const SizedBox(
          key: Key('homeView_initial_sizedBox'),
        );
      case HomeStatus.loading:
        return const Center(
          key: Key('homeView_loading_indicator'),
          child: CircularProgressIndicator.adaptive(),
        );
      case HomeStatus.failure:
        return Center(
          key: const Key('homeView_failure_text'),
          child: Text(l10n.homeRocketFetchErrorMessage),
        );
      case HomeStatus.success:
        return const _RocketList(
          key: Key('homeView_success_rocketList'),
        );
    }
  }
}

class _RocketList extends StatelessWidget {
  const _RocketList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rockets = context.select((HomeCubit cubit) => cubit.state.rockets!);

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
