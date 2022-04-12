// ignore_for_file: prefer_const_constructors
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  group('Launch', () {
    final date = DateTime.now();
    final crewMembers = List.generate(
      3,
      (i) => CrewMember(
        id: '$i',
        name: 'Alejandro Ferrero',
        status: 'active',
        agency: 'Very Good Aliens',
        image:
            'https://media-exp1.licdn.com/dms/image/C4D03AQHVNIVOMkwQaA/profile-displayphoto-shrink_200_200/0/1631637257882?e=1637193600&v=beta&t=jFm-Ckb0KS0Z5hJDbo3ZBSEZSYLHfllUf4N-IV2NDTc',
        wikipedia: 'https://www.wikipedia.org/',
        launches: ['Launch $i'],
      ),
    );
    final launch = Launch(
        id: '1',
        name: 'Starlink Mission 1337',
        dateLocal: date,
        dateUtc: date,
        crew: crewMembers,
        links: Links(
            patch: Patch(
                small: 'https://avatars.githubusercontent.com/u/2918581?v=4'),
            webcast: 'https://www.youtube.com',
            wikipedia: 'https://www.wikipedia.org/'));

    test('supports value comparison', () {
      expect(
        launch,
        Launch(
            id: '1',
            name: 'Starlink Mission 1337',
            crew: crewMembers,
            dateLocal: date,
            dateUtc: date,
            links: Links(
                patch: Patch(
                    small:
                        'https://avatars.githubusercontent.com/u/2918581?v=4'),
                webcast: 'https://www.youtube.com',
                wikipedia: 'https://www.wikipedia.org/')),
      );
    });

    test('has concise toString', () {
      expect(
          Launch(
                  id: '1',
                  name: 'Starlink Mission 1337',
                  dateLocal: date,
                  dateUtc: date,
                  links: Links(
                      patch: Patch(
                          small:
                              'https://avatars.githubusercontent.com/u/2918581?v=4'),
                      webcast: 'https://www.youtube.com',
                      wikipedia: 'https://www.wikipedia.org/'))
              .toString(),
          equals('Latest Launch(1, Starlink Mission 1337)'));
    });

    test('overrides stringify', () {
      expect(
          Launch(
                  id: '1',
                  name: 'Starlink Mission 1337',
                  dateLocal: date,
                  dateUtc: date,
                  links: Links(
                      patch: Patch(
                          small:
                              'https://avatars.githubusercontent.com/u/2918581?v=4'),
                      webcast: 'https://www.youtube.com',
                      wikipedia: 'https://www.wikipedia.org/'))
              .stringify,
          isNull);
    });
    group('Links', () {
      test('supports value comparison', () {
        expect(
          Links(
              patch: Patch(
                  small: 'https://avatars.githubusercontent.com/u/2918581?v=4'),
              webcast: 'https://www.youtube.com',
              wikipedia: 'https://www.wikipedia.org/'),
          Links(
              patch: Patch(
                  small: 'https://avatars.githubusercontent.com/u/2918581?v=4'),
              webcast: 'https://www.youtube.com',
              wikipedia: 'https://www.wikipedia.org/'),
        );
      });

      test('has concise toString', () {
        expect(
            Links(
                    patch: Patch(
                        small:
                            'https://avatars.githubusercontent.com/u/2918581?v=4'),
                    webcast: 'https://www.youtube.com',
                    wikipedia: 'https://www.wikipedia.org/')
                .toString(),
            equals(
                'Links(Webcast: https://www.youtube.com, Wikipedia: https://www.wikipedia.org/)'));
      });

      test('overrides stringify', () {
        expect(
            Links(
                    patch: Patch(
                        small:
                            'https://avatars.githubusercontent.com/u/2918581?v=4'),
                    webcast: 'https://www.youtube.com',
                    wikipedia: 'https://www.wikipedia.org/')
                .stringify,
            isNull);
      });
    });

    group('Patch', () {
      test('supports value comparison', () {
        expect(
          const Patch(
              small: 'https://avatars.githubusercontent.com/u/2918581?v=4'),
          const Patch(
              small: 'https://avatars.githubusercontent.com/u/2918581?v=4'),
        );
      });

      test('has concise toString', () {
        expect(
            Patch(small: 'https://avatars.githubusercontent.com/u/2918581?v=4')
                .toString(),
            equals(
                'Patch(Small: https://avatars.githubusercontent.com/u/2918581?v=4)'));
      });

      test('overrides stringify', () {
        expect(
            Patch(small: 'https://avatars.githubusercontent.com/u/2918581?v=4')
                .stringify,
            isNull);
      });
    });
  });
}
