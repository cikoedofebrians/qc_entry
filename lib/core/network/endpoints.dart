// ignore_for_file: constant_identifier_names

const String BASE_URL = "https://entryqc.id/api";
const String CONTENT_TYPE = "application/json";
const String APP_VERSION = "1.0.0";

// AUTH
const String loginUrl = "/auth/login";
const String logoutUrl = "/auth/logout";
const String meUrl = '/auth/me';
const String versionUrl = '/version/check';

// QUESTION
const String surveyUrl = '/survey';
String surveyQuestionUrl(String id) => '/survey/$id';
const String answerSurveyUrl = '/survey/answer';
String finishSurveyUrl(String id) => '/survey/$id/finish';

// REALCOUUNT
const String dapilUrl = '/dapil';
const String pilpresUrl = '/pilpres';
const String submitPilpresUrl = '/pilpres/submit-suara';
const String pilparUrl = '/pilpar';
const String submitPilparUrl = '/pilpar/submit-suara';
String pillegUrl(int partaiId, int dapilId) => '/pilleg/$partaiId/$dapilId';
const String submitPillegUrl = '/pilleg/submit-suara';
const String pilkadaUrl = '/pilkada';
const String submitPilkadaUrl = '/pilkada/submit-suara';
