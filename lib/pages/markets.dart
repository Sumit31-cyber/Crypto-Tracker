import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:crypto_tracker/widgets/crypto_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_page.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (marketProvider.markets.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
            ),
            child: RefreshIndicator(
              color: Colors.greenAccent,
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoModel currentCrypto = marketProvider.markets[index];
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.transparent,
                            currentCrypto.priceChange24h! < 0
                                ? Colors.red.withOpacity(0.1)
                                : Colors.green.withOpacity(0.2)
                          ],
                        ),
                      ),
                      child: CryptoListTile(currentCrypto: currentCrypto),
                    );
                  }),
            ),
          );
        } else
          return Container();
      },
    );
  }
}
