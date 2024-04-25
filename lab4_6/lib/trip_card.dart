import 'package:flutter/material.dart';
import 'package:lab4_5/trip_page.dart';

class TripCard extends StatelessWidget {
  final String climat; //sun, winter, wind
  final String country; //name of images
  final String period; //Season year - days (Spring 2024 - 14 days)
  final List<String> curators; //names of curators (images name for me)

  const TripCard({
    super.key,
    required this.climat,
    required this.country,
    required this.period,
    required this.curators
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> curatorsWidgets = createCuratorsWidgets(curators);

    return (
      GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TripPage(tripCard: this)),
          );
        },
        child: Container (
          margin: const EdgeInsets.only(bottom: 25),
          width: screenWidth * 1,
          height: screenWidth * 0.5,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage (
              image: AssetImage("assets/images/${country.toLowerCase()}.png"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.65), BlendMode.dstATop)
            ),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(25))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(20, 40, 0, 5),
                child: Image(
                  image: AssetImage("assets/images/$climat.png"),
                  width: 30,
                  height: 30,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                child: Text(
                  country,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      period,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 235, 235, 235),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: curators.length * 30,
                      child: Stack(
                        children: curatorsWidgets,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  List<Widget> createCuratorsWidgets(List<String> curators) {
    List<Widget> widgets = [];

    for (int i = 0; i < curators.length; i++) {
      widgets.add(
        Positioned(
          right: i * 20,
          child: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: ClipOval(child: Image(image: AssetImage("assets/images/${curators[i]}"))),
            ),
          )
        )
      );
    }

    return widgets;
  }
}