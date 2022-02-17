import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoModel currentCrypto =
                  marketProvider.fetchCryptoById(widget.id);

              return RefreshIndicator(
                color: Colors.green,
                onRefresh: () async {
                  await marketProvider.fetchData();
                },
                child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          currentCrypto.image.toString(),
                        ),
                      ),
                      title: Text(
                        currentCrypto.name! +
                            " (${currentCrypto.symbol!.toUpperCase()})",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
                        style: const TextStyle(
                          color: Color(0xFF0395eb),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, right: 18, left: 18, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price Change (24h)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              double priceChange =
                                  currentCrypto.priceChange24h!;
                              double priceChangePercentage =
                                  currentCrypto.priceChangePercentage24h!;
                              if (priceChange < 0) {
                                return Text(
                                  " ${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 25),
                                );
                              } else {
                                return Text(
                                  "+${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 25),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Low 24h',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "₹ " +
                                    currentCrypto.currentPrice!
                                        .toStringAsFixed(4),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Circulating Supply',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                currentCrypto.circulatingSupply.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'All Time Low',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                currentCrypto.atl.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Market Cap Rank',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                " #${currentCrypto.marketCapRank!}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'Low 24h',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "₹ " +
                                    currentCrypto.currentPrice!
                                        .toStringAsFixed(4),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                'All Time High',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                currentCrypto.ath.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
