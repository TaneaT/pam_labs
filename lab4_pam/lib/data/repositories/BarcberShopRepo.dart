import '../../domain/model/BarberShop.dart';

abstract class BarbershopRepository {
  Future<List<Barbershop>> getNearestBarbershops();
  Future<List<Barbershop>> getRecommendedBarbershops();
}
