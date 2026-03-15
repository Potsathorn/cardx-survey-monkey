import 'cardx_survey_monkey_platform_interface.dart';

class CardxSurveyMonkey {
  Future<void> showSurvey(String collectorHash) {
    return CardxSurveyMonkeyPlatform.instance.showSurvey(collectorHash);
  }
}
