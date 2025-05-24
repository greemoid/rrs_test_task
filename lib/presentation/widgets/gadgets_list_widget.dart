import 'package:flutter/material.dart';

import '../../domain/entities/gadget.dart';
import 'expandable_gadget_card_widget.dart';

class GadgetsListWidget extends StatelessWidget {
  const GadgetsListWidget({super.key, required this.gadgets});

  final List<Gadget> gadgets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gadgets.length,
      itemBuilder: (context, index) {
        return ExpandableGadgetCardWidget(
          title: gadgets[index].name,
          data: gadgets[index].data,
        );
      },
    );
  }
}
