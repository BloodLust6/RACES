import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:races/common/widgets/appbar/appbarpage.dart';
import 'package:races/data/repositories/authentication/authentication_repository.dart';
import 'package:races/features/dependent/controllers/dependent_controller.dart';
import 'package:races/features/dependent/model/dependent_model.dart';
import 'package:races/features/dependent/screens/dependent/widgets/dependent_box.dart';
import 'package:races/common/widgets/login_signup/form_divider.dart';
import 'package:races/routes/routes.dart';
import 'package:races/utils/constants/sizes.dart';
import 'package:races/utils/constants/text_strings.dart';

class DependentScreen extends StatelessWidget {
  const DependentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DependentController());
    return Scaffold(
      appBar: SAppBarPage(
        showBackArrow: true,
        title: Text(STexts.dependentTitle,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              // add dependent button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(SRoutes.crtdpndnt),
                  child: const Text(STexts.addDependent),
                ),
              ),
              const SizedBox(height: SSizes.spaceBtwSections),

              // divider
              SFormDivider(dividerText: STexts.dependents.capitalize!),
              const SizedBox(height: SSizes.spaceBtwSections),

              // StreamBuilder to display information from Firebase
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(AuthenticationRepository.instance.authUser?.uid)
                    .collection("Dependents")
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
                          (doc) => DependentBox(
                            dependent: DependentModel.fromSnapshot(doc),
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
