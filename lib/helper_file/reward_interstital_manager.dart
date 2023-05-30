// import 'package:ads_app_demo/helper_file/ad_helper.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class RewardedInterstitialAdManager {
//   late RewardedInterstitialAd _rewardedInterstitialAd;
//
//   void loadRewardedInterstitialAd() {
//     RewardedInterstitialAd.load(
//       adUnitId: AdHelper.rewardedInterstitialAdsUnitId,
//       request: const AdRequest(),
//       rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
//         onAdLoaded: (RewardedInterstitialAd ad) {
//           _rewardedInterstitialAd = ad;
//           _rewardedInterstitialAd.fullScreenContentCallback =
//               FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
//               ad.dispose();
//             },
//             onAdFailedToShowFullScreenContent:
//                 (RewardedInterstitialAd ad, AdError error) {
//               ad.dispose();
//             },
//           );
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('Rewarded interstitial ad failed to load: $error');
//         },
//       ),
//     );
//   }
//
//   void showRewardedInterstitialAd() {
//     if (_rewardedInterstitialAd != null) {
//       _rewardedInterstitialAd.show(
//         onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
//           print('User earned reward: ${reward.amount}');
//           // Perform any actions or updates based on the rewarded ad completion
//         },
//       );
//     } else {
//       print('Rewarded interstitial ad not loaded yet.');
//     }
//   }
// }
