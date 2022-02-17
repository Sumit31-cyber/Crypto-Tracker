import 'dart:async';

import 'package:crypto_tracker/models/api.dart';
import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/models/local_storage.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoModel> markets = [];
  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMatkets();
    List<String> favorites = await LocalStorage.fetchFavorited();
    List<CryptoModel> temp = [];
    for (var market in _markets) {
      CryptoModel newCrypto = CryptoModel.fromJson(market);

      if (favorites.contains(newCrypto.id)) {
        newCrypto.isFavorite = true;
      }

      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

    // Timer(const Duration(seconds: 3), () {
    //   fetchData();
    // });
  }

  CryptoModel fetchCryptoById(String id) {
    CryptoModel crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorite(CryptoModel crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  void removeFavorite(CryptoModel crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavorites(crypto.id!);
    notifyListeners();
  }
}
