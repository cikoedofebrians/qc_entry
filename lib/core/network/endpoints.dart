// ignore_for_file: constant_identifier_names

// const String BASE_URL = "https://entryqc.id/api";
const String BASE_URL = "http://127.0.0.1:8000/api";
const String CONTENT_TYPE = "application/json";

// AUTH
const String loginUrl = "/auth/login";
const String logoutUrl = "/auth/logout";
const String meUrl = '/auth/me';

// QUESTION
const String surveyUrl = '/surveys';
String surveyQuestionUrl(String id) => '/surveys/$id';
String answerSurveyUrl(String id) => '/surveys/$id/answer';
String finishSurveyUrl(String id) => '/surveys/$id/finish';

// REALCOUUNT
const String dapilUrl = '/dapil';
const String pilpresUrl = '/pilpres';
const String submitPilpresUrl = '/pilpres/submit-suara';
const String pilparUrl = '/pilpar';
const String submitPilparUrl = '/pilpar/submit-suara';
String pillegUrl(String partaiId) => '/pilleg/$partaiId';
const String submitPillegUrl = '/pilleg/submit-suara';
