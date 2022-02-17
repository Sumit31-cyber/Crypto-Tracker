import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      List<CryptoModel> favorites = marketProvider.markets
          .where((element) => element.isFavorite == true)
          .toList();
      return (favorites.length > 0)
          ? ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                CryptoModel currentCrypto = favorites[index];
                return CryptoListTile(currentCrypto: currentCrypto);
              })
          : Center(
              child: SvgPicture.asset(
              'assets/crypto.svg',
              height: 200,
              width: 150,
            ));
    });
  }
}
