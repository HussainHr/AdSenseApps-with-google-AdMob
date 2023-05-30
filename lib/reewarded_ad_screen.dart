import 'package:ads_app_demo/helper_file/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardedScreen extends StatefulWidget {
  const RewardedScreen({Key? key}) : super(key: key);

  @override
  State<RewardedScreen> createState() => _RewardedScreenState();
}

class _RewardedScreenState extends State<RewardedScreen> {
  late RewardedAd rewardedAd;
  num totalCoins = 0;
  bool isAdLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTotalCoins();
    //_loadRewardAdd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isAdLoaded) {
      _loadRewardAdd();
    }
  }

  void _loadTotalCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalCoins = prefs.getInt("totalCoins") ?? 0;
    });
  }

  void _savedTotalCoins(num coins) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("totalCoins", coins.toInt());
  }

  void _loadRewardAdd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print("$ad loading");
          setState(() {
            rewardedAd = ad;
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
    if (rewardedAd == null) return;
    //when ad show full screen
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd add) =>
          print('$add onAdShowedFullScreenContent'),

      // when add dismiss on user
      onAdDismissedFullScreenContent: (RewardedAd add) {
        print("$add onAdDismissedFullScreenContent ");

        //dispose the dismiss app
        add.dispose();
        _loadRewardAdd();
      },

      //when ad failed to show
      onAdFailedToShowFullScreenContent: (RewardedAd add, AdError error) {
        print("$add onAdFailedToShowFullScreenContent: $error");

        add.dispose();
        _loadRewardAdd();
      },

      // when impression is detected
      onAdImpression: (RewardedAd add) => print("$add onAdImpression "),
    );
  }

  //show ad method
  void _showRewardedAd() {
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem item) {
        setState(() {
          totalCoins += item.amount;
        });
        _savedTotalCoins(totalCoins);
        print("You earned : $totalCoins");
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
    rewardedAd == null;
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
              'Total Count: $totalCoins',
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
            child: InkWell(
              onTap: _showRewardedAd,
              child: Container(
                height: 40,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Center(
                    child: Text(
                  "EARN COIN BY AD",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
