import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cardx_survey_monkey_method_channel.dart';

abstract class CardxSurveyMonkeyPlatform extends PlatformInterface {
  /// Constructs a CardxSurveyMonkeyPlatform.
  CardxSurveyMonkeyPlatform() : super(token: _token);

  static final Object _token = Object();

  static CardxSurveyMonkeyPlatform _instance = MethodChannelCardxSurveyMonkey();

  /// The default instance of [CardxSurveyMonkeyPlatform] to use.
  ///
  /// Defaults to [MethodChannelCardxSurveyMonkey].
  static CardxSurveyMonkeyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CardxSurveyMonkeyPlatform] when
  /// they register themselves.
  static set instance(CardxSurveyMonkeyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
