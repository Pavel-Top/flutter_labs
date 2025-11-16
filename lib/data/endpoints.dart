class Endpoints {
  Endpoints._();

  static const String desserts = '/filter.php?c=Dessert';
  static String mealDetails(String mealId) => '/lookup.php?i=$mealId';
}