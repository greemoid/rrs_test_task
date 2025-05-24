import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'expandable_gadget_card_widget.dart';

class GadgetsLoadingWidget extends StatelessWidget {
  const GadgetsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ExpandableGadgetCardWidget(title: 'Iphone 11 pro', data: {});
        },
      ),
    );
  }
}
