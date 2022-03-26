import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/core/utils/helpers.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/presentation/screens/home/controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/expandable_med_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/extensions.dart';

class MedicationsTab extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  MedicationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.medications.isEmpty
          ? Center(child: Text('Empty'))
          : ListView.builder(
              itemCount: homeController.medications.length,
              itemBuilder: (_, index) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0.wp,
                  vertical: 2.0.wp,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: expandedListItemState[index]
                  //     ? Border.all(color: secondaryColor, width: 0.5.wp)
                  //     : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      offset: const Offset(0, 1),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    )
                  ],
                ),
                child: ExpandableMedItem(homeController.medications[index]),
              ),
            ),
    );
  }
}
