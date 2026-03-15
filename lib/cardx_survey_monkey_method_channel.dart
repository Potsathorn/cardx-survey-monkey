import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cardx_survey_monkey_platform_interface.dart';

/// An implementation of [CardxSurveyMonkeyPlatform] that uses method channels.
class MethodChannelCardxSurveyMonkey extends CardxSurveyMonkeyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cardx_survey_monkey');

  @override
  Future<void> showSurvey(String collectorHash) async {
    try {
      await methodChannel.invokeMethod(
        'showSurvey',
        {
          "collectorHash": collectorHash,
        },
      );
    } on PlatformException catch (e) {
      print("Error: ${e.code} - ${e.message}");
      // ใส่ Logic แจ้งเตือน User ตรงนี้ เช่น "ไม่สามารถโหลดแบบสอบถามได้"
    }
  }
}
