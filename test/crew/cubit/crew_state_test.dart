import 'package:flutter_test/flutter_test.dart';
import 'package:spacex_demo/crew/cubit/crew_cubit.dart';

void main() {
  group('CrewState', () {
    test('supports value comparison', () {
      expect(
        const CrewState(status: CrewStatus.success, crewMembers: []),
        const CrewState(status: CrewStatus.success, crewMembers: []),
      );
    });
  });
}
