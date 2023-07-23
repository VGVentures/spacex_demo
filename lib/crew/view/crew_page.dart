import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_demo/crew/cubit/crew_cubit.dart';
import 'package:spacex_demo/crew_member_details/crew_member_details.dart';
import 'package:spacex_demo/l10n/l10n.dart';

class CrewPage extends StatelessWidget {
  const CrewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const CrewPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CrewCubit(
        crewMemberRepository: context.read<CrewMemberRepository>(),
      )..fetchAllCrewMembers(),
      child: const CrewView(),
    );
  }
}

class CrewView extends StatelessWidget {
  const CrewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.crewAppBarTitle),
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
    final status = context.select((CrewCubit cubit) => cubit.state.status);

    switch (status) {
      case CrewStatus.initial:
        return const SizedBox(
          key: Key('crewView_initial_sizedBox'),
        );
      case CrewStatus.loading:
        return const Center(
          key: Key('crewView_loading_indicator'),
          child: CircularProgressIndicator.adaptive(),
        );
      case CrewStatus.failure:
        return Center(
          key: const Key('crewView_failure_text'),
          child: Text(l10n.crewFetchErrorMessage),
        );
      case CrewStatus.success:
        return const _CrewMembersList(
          key: Key('crewView_success_crewMemberList'),
        );
    }
  }
}

class _CrewMembersList extends StatelessWidget {
  const _CrewMembersList({super.key});

  @override
  Widget build(BuildContext context) {
    final crewMembers =
        context.select((CrewCubit cubit) => cubit.state.crewMembers!);

    return ListView(
      children: [
        for (final crewMember in crewMembers) ...[
          ListTile(
            isThreeLine: true,
            onTap: () {
              Navigator.of(context).push(
                CrewMemberDetailsPage.route(crewMember: crewMember),
              );
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(crewMember.image),
            ),
            title: Text(crewMember.name),
            subtitle: Text(
              crewMember.agency,
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
