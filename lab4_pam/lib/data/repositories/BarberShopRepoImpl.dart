import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../../domain/model/BarberShop.dart';
import 'BarcberShopRepo.dart';


class BarbershopRepositoryImpl implements BarbershopRepository {
  @override
  Future<List<Barbershop>> getNearestBarbershops() async {
    String data = await rootBundle.loadString('assets/barbershops.json');
    return parseBarbershopList(data);
  }

  @override
  Future<List<Barbershop>> getRecommendedBarbershops() async {
    String data = await rootBundle.loadString('assets/recommended_barbershops.json');
    return parseBarbershopList(data);
  }

  List<Barbershop> parseBarbershopList(String data) {
    final List<dynamic> jsonData = json.decode(data);
    return jsonData.map((item) => Barbershop(
      name: item['name'],
      service: item['service'],
      rating: item['rating'],
      image: item['image'],
    )).toList();
  }
}
