import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917"; // for testing ad unit id
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313"; // for testing iOS ad unit id
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get interstitialAdsUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712"; // for testing ad unit id
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910"; // for testing iOS ad unit id
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get rewardedInterstitialAdsUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5354046379'; // for testing ad unit id
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5354046379'; // for testing iOS ad unit id
    }
    throw UnsupportedError("Unsupported platform");
  }
}
