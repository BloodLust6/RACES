import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/common/widgets/appbar/appbarpage.dart';
import 'package:races/features/information/controllers/information_controller.dart';
import 'package:races/features/information/model/information_model.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/features/information/screens/information/widgets/information_box.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(InformationController());
    return Scaffold(
      appBar: SAppBarPage(
        showBackArrow: true,
        title: Text(STexts.clinicTitle,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
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
                          (doc) => InformationBox(
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
