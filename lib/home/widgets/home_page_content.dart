import 'package:flutter/material.dart';
import 'package:spacex_demo/home/widgets/spacex_tile.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/rockets/rockets.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: SpaceXTile(
            title: l10n.rocketSpaceXTileTitle,
            image: 'assets/images/img_spacex_rocket.jpeg',
            onTap: () => Navigator.of(context).push(
              RocketsPage.route(),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: SpaceXTile(
            title: l10n.crewSpaceXTileTitle,
            image: 'assets/images/img_spacex_crew.jpeg',
            // TODO: CHANGE TO CREW PAGE ROUTE
            onTap: () => Navigator.of(context).push(
              RocketsPage.route(),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
