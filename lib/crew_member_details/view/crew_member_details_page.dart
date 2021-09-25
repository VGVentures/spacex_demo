import 'package:flutter/material.dart';
import 'package:spacex_api/spacex_api.dart';

class CrewMemberDetailsPage extends StatelessWidget {
  const CrewMemberDetailsPage({Key? key}) : super(key: key);

  static Route<CrewMemberDetailsPage> route({required CrewMember crewMember}) {
    // TODO: INCLUDE BlocProvider and CrewMemberDetailsCubit
    return MaterialPageRoute(
      builder: (context) => const CrewMemberDetailsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CrewMemberDetailsView();
  }
}

class CrewMemberDetailsView extends StatelessWidget {
  const CrewMemberDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crew Member Details'),
      ),
      body: const Text('All good'),
    );
  }
}
