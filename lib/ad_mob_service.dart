import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
    static String? get bannerAdUnitId {
        if (defaultTargetPlatform == TargetPlatform.android){
            return 'ca-app-pub-9521073216034480/9045103231';
        }
        return null;
    }

    static String? get interstitialAdUnitId {
        if (defaultTargetPlatform == TargetPlatform.android){
            return 'ca-app-pub-9521073216034480/9045103231';
        }
        return null;
    }

    InterstitialAd? _interstitialAd;
    bool _isInterstitialAdReady = false;

    // Constructor
    AdMobService() {
        MobileAds.instance.initialize();
        loadInterstitialAd();
    }

    // Método para cargar el anuncio intersticial
    void loadInterstitialAd() {
        InterstitialAd.load(
            adUnitId: "ca-app-pub-9521073216034480/9045103231",
            request: AdRequest(),
            adLoadCallback: InterstitialAdLoadCallback(
                onAdLoaded: (ad) {
                    _interstitialAd = ad;
                    _isInterstitialAdReady = true;
                },
                onAdFailedToLoad: (error) {
                    _isInterstitialAdReady = false;
                    print('Failed to load interstitial ad: $error');
                },
            ),
        );
    }

    void showInterstitialAd() {
        if (_isInterstitialAdReady && _interstitialAd != null) {
            _interstitialAd!.show();
        } else {
            print('Interstitial ad is not ready yet.');
        }
    }

}