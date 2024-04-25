import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            "My trips",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 0),
                child: const Image(
                  image: AssetImage("assets/images/grid.png"),
                  width: 40,
                  height: 40,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 0, 3),
                child: Image.asset(
                  "assets/images/earth.png",
                  width: 40,
                  height: 40,
                  color: Colors.white.withOpacity(0.4),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}