import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/crew_member_details/cubit/crew_member_details_cubit.dart';
import 'package:spacex_demo/crew_member_details/widgets/widgets.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class CrewMemberDetailsPage extends StatelessWidget {
  const CrewMemberDetailsPage({super.key});

  static Route<void> route({required CrewMember crewMember}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => CrewMemberDetailsCubit(crewMember: crewMember),
        child: const CrewMemberDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CrewMemberDetailsView();
  }
}

class CrewMemberDetailsView extends StatelessWidget {
  const CrewMemberDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final crewMember = context
        .select((CrewMemberDetailsCubit cubit) => cubit.state.crewMember);

    return Scaffold(
      appBar: AppBar(
        title: Text(crewMember.name),
      ),
      body: Stack(
        children: [
          ListView(
            children: const [
              ImageHeader(
                key: Key('crewMemberDetailsPage_imageHeader'),
              ),
              TitleHeader(
                key: Key('crewMemberDetailsPage_titleHeader'),
              ),
            ],
          ),
          Positioned(
            left: 16,
            bottom: 16,
            right: 16,
            child: SizedBox(
              height: 64,
              child: ElevatedButton(
                key: const Key(
                  'crewMemberDetailsPage_openWikipedia_elevatedButton',
                ),
                onPressed: () async {
                  final uri = Uri.parse(crewMember.wikipedia);

                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
                child: Text(l10n.openWikipediaButtonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
