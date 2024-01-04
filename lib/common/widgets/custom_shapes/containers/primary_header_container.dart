import 'package:flutter/material.dart';
import 'package:races/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:races/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:races/utils/constants/colors.dart';
import 'package:races/utils/helpers/helper_functions.dart';

class SPrimaryHeaderContainer extends StatelessWidget {
  const SPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return SCurvedEdgeWidget(
      child: Container(
        color: dark ? SColors.darkerGrey : SColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: SCircularContainer(
                  backgroundColor: SColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: SCircularContainer(
                  backgroundColor: SColors.textWhite.withOpacity(0.1),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
