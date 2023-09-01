import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight / 20,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: InkWell(
        onTap: () =>  Navigator.pushNamedAndRemoveUntil(context, '/categories', (route) => false),
        child: Padding(
          padding: EdgeInsets.only(top: 3.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.home,
                  color: Theme.of(context).colorScheme.primary,
              ),
              Text('Home', style: TextStyle(fontSize: 10),)
            ],
          
          )
        )
      )
    );
  }
}