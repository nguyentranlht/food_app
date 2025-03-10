class Meal {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  // final String strYoutube; // Duplicate declaration removed
  final String strMealThumb;
  final String strInstructions;
  final String strYoutube;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.strYoutube,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strYoutube: json['strYoutube'],
      strMealThumb: json['strMealThumb'],
    );
  }
}