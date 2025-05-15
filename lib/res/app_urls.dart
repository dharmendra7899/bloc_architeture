class AppUrls {
  static String get liveBaseUrl => 'https://api.policyvault.in';

  static String get mainBaseUrl => '$liveBaseUrl/api/v1.0/';

  ///user apis end points
  static String get sendOTPEndPoint => '${mainBaseUrl}users/generateotp/';
}
