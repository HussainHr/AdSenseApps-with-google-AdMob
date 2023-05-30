import 'package:ads_app_demo/helper_file/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardedInterStitialScreen extends StatefulWidget {
  const RewardedInterStitialScreen({Key? key}) : super(key: key);

  @override
  State<RewardedInterStitialScreen> createState() =>
      _RewardedInterStitialScreenState();
}

class _RewardedInterStitialScreenState
    extends State<RewardedInterStitialScreen> {
  late RewardedInterstitialAd _rewardedInterstitialAd;
  num totalCoinCounts = 0;
  bool isAdLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTotalCoins();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isAdLoaded) {
      rewardInterstitalAd();
    }
  }

  void _loadTotalCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalCoinCounts = prefs.getInt("totalCoinCounts") ?? 0;
    });
  }

  void _savedTotalCoins(num coins) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("totalCoinCounts", coins.toInt());
  }

  void rewardInterstitalAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdHelper.rewardedInterstitialAdsUnitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (RewardedInterstitialAd ad) {
          print("$ad loading");
          setState(() {
            _rewardedInterstitialAd = ad;
          });
          //set full screen content call back
          _setFullScreenContentCallBack();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Faild to load add $error");
        },
      ),
    );
  }

  void _setFullScreenContentCallBack() {
    if (_rewardedInterstitialAd == null) return;
    //when ad show full screen
    _rewardedInterstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd add) =>
          print('$add onAdShowedFullScreenContent'),

      // when add dismiss on user
      onAdDismissedFullScreenContent: (RewardedInterstitialAd add) {
        print("$add onAdDismissedFullScreenContent ");

        //dispose the dismiss app
        add.dispose();
        rewardInterstitalAd();
      },

      //when ad failed to show
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd add, AdError error) {
        print("$add onAdFailedToShowFullScreenContent: $error");

        add.dispose();
        rewardInterstitalAd();
      },

      // when impression is detected
      onAdImpression: (RewardedInterstitialAd add) =>
          print("$add onAdImpression "),
    );
  }

  void _showRewardedAd() {
    _rewardedInterstitialAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem item) {
        setState(() {
          totalCoinCounts += item.amount;
        });
        _savedTotalCoins(totalCoinCounts);
        print("You earned : $totalCoinCounts");

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Congratulations!'),
              content: Text('You earned ${item.amount} points.'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
    _rewardedInterstitialAd == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Total Count: $totalCoinCounts',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showRewardedAd();
              },
              child: const Text('Load Rewarded Interstitial Ad'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //rewardedInterstitialAdManager.showRewardedInterstitialAd();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
