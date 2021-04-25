import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/rocket_details/rocket_details.dart';
import 'package:spacex_demo/l10n/l10n.dart';

class RocketDetailsPage extends StatelessWidget {
  const RocketDetailsPage({Key? key}) : super(key: key);

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
    return RocketDetailsView();
  }
}

class RocketDetailsView extends StatelessWidget {
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
              if (rocket.flickrImages.isNotEmpty) _ImageHeader(),
              _TitleHeader(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: _DescriptionSection(),
              ),
              const SizedBox(
                height: 80.0,
              ),
            ],
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            right: 16.0,
            child: Container(
              height: 64.0,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement.
                  print('Implement me.');
                },
                child: Text(l10n.rocketDetailsOpenWikipediaButtonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final imageUrl = context.select(
      (RocketDetailsCubit cubit) => cubit.state.rocket.flickrImages.first,
    );

    return SizedBox(
      height: 240.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(8.0),
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
            style: Theme.of(context).textTheme.headline5,
          ),
          if (rocket.active != null) ...[
            const SizedBox(width: 4.0),
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
          : Text(l10n.rocketDetailsFirstFlightSubtitle(
              DateFormat('dd-MM-yyyy').format(rocket.firstFlight!),
            )),
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
