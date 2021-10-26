import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_demo/crew_member_details/cubit/crew_member_details_cubit.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = context.select(
      (CrewMemberDetailsCubit cubit) => cubit.state.crewMember.image,
    );

    return SizedBox(
      height: 450,
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
