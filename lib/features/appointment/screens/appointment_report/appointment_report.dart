import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/common/widgets/appbar/appbarpage.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/features/appointment/model/appointment_model.dart';
import 'package:races/features/appointment/screens/appointment_report/widgets/appointment_report_box.dart';
import 'package:races/features/medication/controllers/medication_controller.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class AppointmentRecordScreen extends StatelessWidget {
  const AppointmentRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MedicationController());
    return Scaffold(
      appBar: SAppBarPage(
        showBackArrow: false,
        title: Text(STexts.appntmntreports,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              // divider
              SFormDivider(dividerText: STexts.appointments.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              // StreamBuilder to display medication from Firebase
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collectionGroup("AppointmentReports")
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
                          (doc) => AppointmentReportBox(
                            appointment: AppointmentModel.fromSnapshot(doc),
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
