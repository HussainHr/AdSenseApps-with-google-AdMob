import 'package:ads_app_demo/helper_file/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class StreamAdScreen extends StatefulWidget {
  const StreamAdScreen({Key? key}) : super(key: key);

  @override
  State<StreamAdScreen> createState() => _StreamAdScreenState();
}

class _StreamAdScreenState extends State<StreamAdScreen> {
  late InterstitialAd interstitialAd;
  bool isAdLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInterstitialAd();
  }

  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdsUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          setState(() {
            isAdLoaded = true;
          });
          interstitialAd.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            setState(() {
              isAdLoaded = false;
            });
            print('Add is dismissed');
          }, onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            setState(() {
              isAdLoaded = false;
            });
          });
        }, onAdFailedToLoad: (error) {
          interstitialAd.dispose();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (isAdLoaded) {
              interstitialAd.show();
            }
          },
          child: const Text("Complete your task"),
        ),
      ),
    );
  }
}
