import 'package:flutter/material.dart';

import '../../domain/model/BarberShop.dart';
import 'BarberShopCard.dart';


class BarbershopList extends StatelessWidget {
  final List<Barbershop> barbershops;

  BarbershopList(this.barbershops);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: barbershops.length,
        itemBuilder: (context, index) {
          final shop = barbershops[index];
          return BarbershopCard(shop);
        },
      ),
    );
  }
}
