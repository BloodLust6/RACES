import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/common/widgets/appbar/appbarpage.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/features/medication/model/medication_model.dart';
import 'package:races/features/medication/screens/medication/widgets/medication_box.dart';
import 'package:races/features/medication/screens/medication_report/widgets/medication_report_box.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicationController());
    return Scaffold(
      appBar: SAppBarPage(
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
                    .collection("Users")
                    .doc(AuthenticationRepository.instance.authUser?.uid)
                    .collection("Medications")
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
                          (doc) => MedicationBox(
                            medication: MedicationModel.fromSnapshot(doc),
                          ),
                        )
                        .toList(),
                  );
                },
              ),

              // StreamBuilder to display medication from Firebase
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(AuthenticationRepository.instance.authUser?.uid)
                    .collection("MedicationReports")
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
                          (doc) => MedicationReportBox(
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
