import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  const GradientAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body:
      CustomScrollView (
        slivers: <Widget>[
          // sliverappbar for gradient widget
          SliverAppBar (
            pinned: true,
            expandedHeight: 50,
            flexibleSpace: Container (
              decoration: BoxDecoration (
                // LinearGradient
                gradient: LinearGradient (
                  // colors for gradient
                  colors: [
                    Colors.deepPurpleAccent,
                    Colors.yellowAccent,
                  ],
                ),
              ),
            ),
            // title of appbar
            title: Text ("Gradient AppBar!"),
          ),
          SliverList (
            delegate: SliverChildListDelegate ([
              // Body Element
            ],
            ),
          ),
        ],
      ),
    );

  }
}
