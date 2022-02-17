import 'package:crypto_tracker/models/crypto_model.dart';
import 'package:crypto_tracker/pages/detail_page.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoModel currentCrypto;
  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    id: currentCrypto.id!,
                  ))),
      contentPadding: const EdgeInsets.all(0),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              currentCrypto.name!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 18,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavorite(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 18,
                    color: Colors.red,
                  ),
                ),
        ],
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
              style: const TextStyle(
                color: Color(0xFF0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Builder(
              builder: (context) {
                double priceChange = currentCrypto.priceChange24h!;
                double priceChangePercentage =
                    currentCrypto.priceChangePercentage24h!;
                if (priceChange < 0) {
                  return Text(
                    " ${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})",
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Text(
                    "+${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})",
                    style: const TextStyle(color: Colors.green),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
