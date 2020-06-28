import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeZone {
  static const MethodChannel _channel = const MethodChannel('time_zone');

  TimeZone({
    @required this.id,
    @required this.offset,
  });

  // 时区的id，如 Pacific/Auckland
  final String id;
  // 时区相对于UTC时间的偏移量，如 8
  final int offset;

  static Future<TimeZone> currentZone() async {
    final Map map = await _channel.invokeMethod('getTimeZoneData');
    TimeZone timeZone = TimeZone(id: map['id'], offset: map['offset']);
    return timeZone;
  }

  @override
  String toString() {
    return 'time zone==>id: $id, offset: $offset';
  }
}
