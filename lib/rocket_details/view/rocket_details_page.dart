import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/l10n/l10n.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';
import 'package:url_launcher/url_launcher.dart';

class RocketDetailsPage extends StatelessWidget {
  const RocketDetailsPage({super.key});

  static Route<void> route({required Rocket rocket}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => RocketDetailsCubit(rocket: rocket),
        child: const RocketDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const RocketDetailsView();
  }
}

class RocketDetailsView extends StatelessWidget {
  const RocketDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final rocket =
        context.select((RocketDetailsCubit cubit) => cubit.state.rocket);

    return Scaffold(
      appBar: AppBar(
        title: Text(rocket.name),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              if (rocket.flickrImages.isNotEmpty)
                const _ImageHeader(
                  key: Key('rocketDetailsPage_imageHeader'),
                ),
              const _TitleHeader(
                key: Key('rocketDetailsPage_titleHeader'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: _DescriptionSection(),
              ),
              if (rocket.wikipedia != null)
                const SizedBox(
                  height: 80,
                ),
            ],
          ),
          if (rocket.wikipedia != null)
            Positioned(
              left: 16,
              bottom: 16,
              right: 16,
              child: SizedBox(
                height: 64,
                child: ElevatedButton(
                  key: const Key(
                    'rocketDetailsPage_openWikipedia_elevatedButton',
                  ),
                  onPressed: () async {
                    final uri = Uri.parse(rocket.wikipedia!);

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

class _ImageHeader extends StatelessWidget {
  const _ImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = context.select(
      (RocketDetailsCubit cubit) => cubit.state.rocket.flickrImages.first,
    );

    return SizedBox(
      height: 240,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(8),
          ),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _TitleHeader extends StatelessWidget {
  const _TitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final rocket =
        context.select((RocketDetailsCubit cubit) => cubit.state.rocket);

    return ListTile(
      title: Row(
        children: [
          Text(
            rocket.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if (rocket.active != null) ...[
            const SizedBox(width: 4),
            if (rocket.active!)
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
        ],
      ),
      subtitle: rocket.firstFlight == null
          ? null
          : Text(
              l10n.rocketDetailsFirstFlightSubtitle(
                DateFormat('dd-MM-yyyy').format(rocket.firstFlight!),
              ),
            ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final description = context.select(
      (RocketDetailsCubit cubit) => cubit.state.rocket.description,
    );

    return Text(description);
  }
}
