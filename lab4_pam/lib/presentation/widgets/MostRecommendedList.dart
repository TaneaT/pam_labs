import 'package:flutter/material.dart';

import '../../domain/model/BarberShop.dart';
import 'BarberShopCard.dart';


class MostRecommendedList extends StatelessWidget {
  final List<Barbershop> recommendedShops;

  MostRecommendedList(this.recommendedShops);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: recommendedShops.length,
        itemBuilder: (context, index) {
          final shop = recommendedShops[index];
          return BarbershopCard(shop);
        },
      ),
    );
  }
}
