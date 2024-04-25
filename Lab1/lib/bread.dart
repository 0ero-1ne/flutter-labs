import 'package:lab1/food_factory.dart';

mixin class Product {
  String _creationDate = "product";
  String get creationDate => _creationDate;
  
  set creationDate (String value) {
        if (value != "") {
            _creationDate = value;
        }
    }
}

class Bread extends FoodFactory with Product implements Comparable<Bread> {
    late int _weight;
    
    Bread(super._name, super._calories, this._weight);
    
    Bread.food(super._name, super._calories) {
      _creationDate = "15.03.2024";
      _weight = 0;
    }

    set weight(int value) {
        if (value > 0 && value < 10000) {
            _weight = value;
        }
    }

    int get weight => _weight;

    @override
    String getFoodInfo() {
        return "Name: $name\nCalories: $calories\nWeight: $weight";
    }

  @override
  int compareTo(Bread other) {
    if (calories! > other.calories!) {
      return 1;
    }
    if (calories! < other.calories!) {
      return 2;
    }
    return 0;
  }

  Map toJson() => {
    'name': name,
    'calories': calories,
    'weigth': weight
  };
}