import 'package:flutter/material.dart';
import 'package:lab9/trip_card.dart';
import 'package:flutter/services.dart';

class TripPage extends StatelessWidget {
  final TripCard tripCard;
  const TripPage({ super.key, required this.tripCard });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ));

    final screenWidth = MediaQuery.of(context).size.width;
    List<Widget> curatorsWidgets = createCuratorsWidgets(tripCard.curators);

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenWidth * 0.7,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage (
                  image: AssetImage("assets/images/${tripCard.country.toLowerCase()}.png"),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.65), BlendMode.dstATop)
                ),
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 45, 25, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "< Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                        ),
                        const Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 40, 0, 5),
                    child: Image(
                      image: AssetImage("assets/images/${tripCard.climat}.png"),
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                    child: Text(
                      tripCard.country,
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
                          tripCard.period,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 235, 235, 235),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: tripCard.curators.length * 30,
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
            Container(
              margin: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: const Text(
                "Description",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          ],
        )
      ),
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