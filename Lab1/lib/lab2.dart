import 'package:lab1/bread.dart';
import 'package:lab1/food_factory.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

void printInfo() {
    logger.d("Changed");
}

void main() {
    try {
        Bread breadOne = Bread.food('Black bread', 350);
        Bread breadTwo = Bread('White bread', 234, 750);
        FoodFactory.addObject();
        logger.d(FoodFactory.amountOfObjects);

        logger.d(breadOne.greetFood(foodName: 'Apple'));
        logger.d(breadTwo.greetFoodTwo(foodName: 'Pear'));
        breadTwo.changeCalories(566, printInfo);
        logger.d(breadTwo.calories);

        var list = <String>['a', 'b'];
        list.add('c');
        logger.d(list);

        var arr = [1, 2, 3, 4, 5];
        logger.d(arr);
        arr[3] = 0;
        logger.d(arr);

        var set = <int>{1, 2, 2, 1, 4};
        set.add(6);
        logger.d(set);

        for (int i = 0; i < 10; i++) {
            if (i % 2 == 0) {
                continue;
            }
            if (i == 7) {
                break;
            }
            logger.d(i);
        }

        int a = 10;
        int b = 0;
        int c = a ~/ b;

        print(c);
    }
    catch(e) {
        logger.d("Exception $e");
    }
}