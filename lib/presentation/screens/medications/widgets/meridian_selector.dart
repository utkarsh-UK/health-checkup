import 'package:care_monitor/core/theme/colors.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';

class MeridianSelector extends StatefulWidget {
  final Function(String) onTap;

  const MeridianSelector({Key? key, required this.onTap}) : super(key: key);

  @override
  _MeridianSelectorState createState() => _MeridianSelectorState();
}

class _MeridianSelectorState extends State<MeridianSelector> {
  bool isAMSelected = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() => isAMSelected = true);
            widget.onTap('AM');
          },
          child: Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: EdgeInsets.symmetric(
                vertical: 5.0.wp,
                horizontal: 6.0.wp,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                color: isAMSelected ? const Color(0xFFE9EEF4) : Colors.white,
                borderRadius: BorderRadius.circular(1.0.wp),
              ),
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 400),
                style: textTheme.headline5!.copyWith(
                  fontSize: 12.0.sp,
                  color:
                      isAMSelected ? const Color(0xFF61A7B7) : primaryTextColor,
                ),
                child: const Text('AM'),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() => isAMSelected = false);
            widget.onTap('PM');
          },
          child: Flexible(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: EdgeInsets.symmetric(
                vertical: 5.0.wp,
                horizontal: 6.0.wp,
              ),
              decoration: BoxDecoration(
                color: !isAMSelected ? const Color(0xFFE9EEF4) : Colors.white,
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(1.0.wp),
              ),
              child: FittedBox(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 400),
                  style: textTheme.headline5!.copyWith(
                    fontSize: 12.0.sp,
                    color: !isAMSelected
                        ? const Color(0xFF61A7B7)
                        : primaryTextColor,
                  ),
                  child: const Text('PM'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
