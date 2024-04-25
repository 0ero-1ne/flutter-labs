import 'package:lab1/food.dart';

abstract class FoodFactory implements Food {
    late String _name;
    late double _calories;

    static int amountOfObjects = 0;
    static const String staticString = "Dmitry";

    static void addObject() => amountOfObjects++;
    static String getStaticString() => staticString;

    FoodFactory(this._name, this._calories) {
        addObject();
    }

    set name (String? value) {
        if (value != "" && value != null) {
            _name = value;
        }
    }

    String? get name => _name;

    set calories(double? value) {
        if (value! > 0 && value < 3000) {
            _calories = calories!;
        }
    }

    double? get calories => _calories;

    @override
    String getFoodInfo() {
        return "Name: $_name\nCalories: $_calories";
    }

    String? greetFood({String? foodName}) {
        return "Hello, $foodName";
    }

    String? greetFoodTwo({String foodName = ''}) {
        if (foodName == '') {
            return "Hello, $name";
        }
        return "Hello, $foodName";
    }

    void changeCalories(double? additionalCalories, Function callback) {
        if (additionalCalories! > 0) {
            _calories = additionalCalories;
            callback();
        }
    }

    String? optionalParameter(String foodName, [double? calories]) {
        if (calories != null) {
            return "Hello, $foodName";
        }
        return "Hello, $foodName with $calories calories";
    }
}