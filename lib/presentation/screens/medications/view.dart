import 'package:care_monitor/core/theme/colors.dart';
import 'package:care_monitor/domain/entities/medication.dart';
import 'package:care_monitor/presentation/screens/home/controller.dart';
import 'package:care_monitor/presentation/screens/medications/widgets/expandable_med_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/extensions.dart';

class MedicationsTab extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

  MedicationsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(() {
      if (homeController.medications.isEmpty) {
        return const Center(child: Text('Empty'));
      } else {

        return SingleChildScrollView(
          key: UniqueKey(),
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: homeController.categorizedMedications.keys
                .toList()
                .map<Widget>((period) => homeController.categorizedMedications[period]!.isEmpty
                    ? const SizedBox.shrink()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.0.wp,
                              top: 6.0.wp,
                              bottom: 0.5.wp,
                            ),
                            child: Text(
                              period,
                              style: textTheme.bodyText2!.copyWith(
                                fontSize: 12.0.sp,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeController.categorizedMedications[period]!.length,
                            itemBuilder: (_, index) => MedItem(
                              medication: homeController.categorizedMedications[period]![index],
                              key: UniqueKey(),
                            ),
                          )
                        ],
                      ))
                .toList(),
          ),
        );
      }
    });
  }
}

class MedItem extends StatefulWidget {
  final Medication medication;

  const MedItem({Key? key, required this.medication}) : super(key: key);

  @override
  State<MedItem> createState() => _MedItemState();
}

class _MedItemState extends State<MedItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 4.0.wp,
        vertical: 2.0.wp,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isExpanded
            ? Border.all(color: secondaryColor, width: 0.5.wp)
            : Border.all(color: Colors.transparent, width: 0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0, 1),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: ExpandableMedItem(
        widget.medication,
        onExpandedChanged: (value) => setState(() => isExpanded = value),
      ),
    );
  }
}
