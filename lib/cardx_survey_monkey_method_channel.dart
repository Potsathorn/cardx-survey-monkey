import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cardx_survey_monkey_platform_interface.dart';

/// An implementation of [CardxSurveyMonkeyPlatform] that uses method channels.
class MethodChannelCardxSurveyMonkey extends CardxSurveyMonkeyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cardx_survey_monkey');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
