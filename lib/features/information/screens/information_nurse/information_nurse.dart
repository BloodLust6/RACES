import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/common/widgets/appbar/appbarpage_nurse.dart';
import 'package:races/features/information/controllers/information_controller.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/features/information/screens/information_nurse/widgets/information_box_nurse.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class InformationNurseScreen extends StatelessWidget {
  const InformationNurseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InformationController());
    return Scaffold(
      appBar: SAppBarNursePage(
        showBackArrow: true,
        title: Text(STexts.clinicTitle,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              // add information button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(SRoutes.crtinfo),
                  child: const Text(STexts.addInfo),
                ),
              ),
              const SizedBox(height: SSizes.spaceBtwSections),

              // divider
              SFormDivider(dividerText: STexts.informations.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              // StreamBuilder to display information from Firebase
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Informations')
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
                          (doc) => InformationNurseBox(
                            information: InformationModel.fromSnapshot(doc),
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
