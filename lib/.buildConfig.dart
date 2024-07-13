class BuildConfig {
  final String recaptchaSiteKey;
  final String recaptchaSecretKey;

  BuildConfig({
    required this.recaptchaSiteKey,
    required this.recaptchaSecretKey,
  });

  static final BuildConfig instance = BuildConfig(
    recaptchaSiteKey: _config["recaptchaSiteKey"],
    recaptchaSecretKey: _config["recaptchaSecretKey"],
  );

  static const Map<String, dynamic> _config = {
    "recaptchaSiteKey": "<YOUR RECAPTCHA SITE KEY>",
    "recaptchaSecretKey": "<YOUR RECAPTCHA SECRET KEY>",
  };
}
