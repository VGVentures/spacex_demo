// ignore_for_file: prefer_const_constructors
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  group('Launch', () {
    test('supports value comparison', () {
      expect(
          Launch(
              id: '1',
              name: 'Starlink Mission 1337',
              links: Links(
                  patch: Patch(
                      small:
                          'https://avatars.githubusercontent.com/u/2918581?v=4'),
                  webcast: 'https://www.youtube.com',
                  wikipedia: 'https://www.wikipedia.org/')),
          Launch(
              id: '1',
              name: 'Starlink Mission 1337',
              links: Links(
                  patch: Patch(
                      small:
                          ' https://avatars.githubusercontent.com/u/2918581?v=4'),
                  webcast: 'https://www.youtube.com',
                  wikipedia: 'https://www.wikipedia.org/')));
    });

    test('has concise toString', () {
      expect(
          Launch(
                  id: '1',
                  name: 'Starlink Mission 1337',
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
