import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/common/widgets/appbar/appbarpage_nurse.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/features/medication/model/medication_model.dart';
import 'package:races/features/medication/screens/medication_nurse/widgets/medication_box_nurse.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class MedicationScreenNurse extends StatelessWidget {
  const MedicationScreenNurse({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicationController());
    return Scaffold(
      appBar: SAppBarNursePage(
        showBackArrow: false,
        title: Text(STexts.medicationTitle,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              // divider
              SFormDivider(dividerText: STexts.medications.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              // StreamBuilder to display medication from Firebase
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collectionGroup("Medications")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  // Data is ready
                  final List<DocumentSnapshot<Map<String, dynamic>>> documents =
                      snapshot.data!.docs;

                  return Column(
                    children: documents
                        .map(
                          (doc) => MedicationBoxNurse(
                            medication: MedicationModel.fromSnapshot(doc),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
