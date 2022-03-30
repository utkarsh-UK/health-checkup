import 'package:flutter/material.dart';

import '../../core/utils/extensions.dart';

class EmptyData extends StatelessWidget {
  final String embedText;
  final bool shouldExpand;

  const EmptyData(this.embedText, {Key? key, this.shouldExpand = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final containerHeight = shouldExpand ? size.height : size.height * 0.5;

    return Container(
      height: shouldExpand ? size.height : size.height * 0.5,
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 8.0.wp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: (!shouldExpand ? size.height : containerHeight) * 0.35,
            width: size.width * 0.8,
            child: Image.asset('assets/images/empty.png', fit: BoxFit.cover),
          ),
          SizedBox(height: 6.0.wp),
          Text('No $embedText to display.\nAdd one to get started now.',
              style: textTheme.headline5),
        ],
      ),
    );
  }
}
