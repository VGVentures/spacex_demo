import 'package:flutter/material.dart';
import 'package:spacex_demo/crew/crew.dart';
import 'package:spacex_demo/home/home.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/rockets/rockets.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: SpaceXCategoryCard(
                key: const Key('homePageContent_rocket_spaceXCategoryCard'),
                onTap: () => Navigator.of(context).push(RocketsPage.route()),
                title: Text(l10n.rocketSpaceXTileTitle),
                imageUrl: 'assets/images/img_spacex_rocket.jpeg',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: SpaceXCategoryCard(
                key: const Key('homePageContent_crew_spaceXCategoryCard'),
                onTap: () => Navigator.of(context).push(CrewPage.route()),
                title: Text(l10n.crewSpaceXTileTitle),
                imageUrl: 'assets/images/img_spacex_crew.jpeg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
