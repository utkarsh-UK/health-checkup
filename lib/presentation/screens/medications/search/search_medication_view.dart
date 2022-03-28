import 'package:care_monitor/presentation/screens/medications/add/add_medication_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/extensions.dart';
import '../../../widgets/tabbed_app_bar.dart';
import '../medication_controller.dart';

class SearchMedicationView extends StatelessWidget {
  final MedicationController addMedicationController =
      Get.find<MedicationController>();

  SearchMedicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomTabbedAppBar(
        showHomeScreenBar: false,
        screenTitle: 'Add New Medication',
        onBackPressed: Get.back,
        showTabBar: false,
      ),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0.wp, horizontal: 6.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Medication name',
                    style: textTheme.subtitle2, softWrap: false),
                SizedBox(height: 2.0.wp),
                TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    style: textTheme.headline5,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0),
                        borderSide: const BorderSide(
                            width: 0.0, style: BorderStyle.none),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryTextColor.withOpacity(0.4),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade300),
                      ),
                    ),
                  ),
                  hideSuggestionsOnKeyboardHide: false,
                  keepSuggestionsOnLoading: false,
                  loadingBuilder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) return [];

                    return await addMedicationController
                        .searchMedications(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion, style: textTheme.headline5),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 3.0.wp),
                        child: Divider(
                          color: Colors.grey.withOpacity(0.5),
                          thickness: 0.4.wp,
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    addMedicationController.searchController.text = suggestion;
                    addMedicationController.nameController.text = suggestion;

                    Get.to(() => AddMedicationView());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
