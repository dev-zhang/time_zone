import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_zone/time_zone.dart';

void main() {
  const MethodChannel channel = MethodChannel('time_zone');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      print('===setUp: $methodCall');
      if (methodCall.method == 'getTimeZoneData') {
        return {
          'id': 'Asia/Shanghai',
          'offset': 8,
        };
      } else {
        return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getTimeZoneData', () async {
    final zone = await TimeZone.currentZone();
    expect(zone.id, 'Asia/Shanghai');
    expect(zone.offset, 8);
  });
}
