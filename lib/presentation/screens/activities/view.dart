import 'package:flutter/material.dart';

class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
    );
  }
}
