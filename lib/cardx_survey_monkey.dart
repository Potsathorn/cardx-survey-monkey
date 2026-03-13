
import 'cardx_survey_monkey_platform_interface.dart';

class CardxSurveyMonkey {
  Future<String?> getPlatformVersion() {
    return CardxSurveyMonkeyPlatform.instance.getPlatformVersion();
  }
}
