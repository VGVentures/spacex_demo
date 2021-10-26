import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_demo/crew_member_details/cubit/crew_member_details_cubit.dart';
import 'package:spacex_demo/l10n/l10n.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final crewMember = context
        .select((CrewMemberDetailsCubit cubit) => cubit.state.crewMember);

    return ListTile(
      isThreeLine: true,
      title: Row(
        children: [
          Text(
            crewMember.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(width: 4),
          if (crewMember.status == 'active')
            const Icon(
              Icons.check,
              color: Colors.green,
            )
          else
            const Icon(
              Icons.close,
              color: Colors.red,
            ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            key: const Key('crewMemberDetailsPage_titleHeader_agencyRichText'),
            text: TextSpan(
              text: '${l10n.crewMemberDetailsAgency}: ',
              style: const TextStyle(
                color: Color(0xFFB3B3B3),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: crewMember.agency,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            key: const Key('crewMemberDetailsPage_titleHeader_launchRichText'),
            text: TextSpan(
              text: '${l10n.crewMemberDetailsParticipatedLaunches} ',
              style: const TextStyle(color: Color(0xFFB3B3B3)),
              children: <TextSpan>[
                TextSpan(
                  text:
                      // ignore: lines_longer_than_80_chars
                      '${crewMember.launches.length} ${crewMember.launches.length == 1 ? l10n.crewMemberDetailsLaunch : l10n.crewMemberDetailsLaunches}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
