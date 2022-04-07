import 'package:launch_repository/launch_repository.dart';

Future<void> main() async {
  final launchRepository = LaunchRepository();
  try {
    final latestLaunch = await launchRepository.fetchLatestLaunch();

    print(latestLaunch);
  } on Exception catch (e) {
    print(e);
  }
}
