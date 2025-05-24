import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rrs_test_task/presentation/widgets/gadgets_loading_widget.dart';

import '../cubit/gadget_cubit.dart';
import '../widgets/gadget_error_widget.dart';
import '../widgets/gadgets_list_widget.dart';

class GadgetsPage extends StatefulWidget {
  const GadgetsPage({super.key, required this.title});

  final String title;

  @override
  State<GadgetsPage> createState() => _GadgetsPageState();
}

class _GadgetsPageState extends State<GadgetsPage> {
  @override
  void initState() {
    super.initState();
    _getGadgets();
  }

  void _getGadgets() {
    context.read<GadgetCubit>().getGadgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocBuilder<GadgetCubit, GadgetState>(
        builder: (context, state) {
          switch (state) {
            case GadgetLoading():
              return const GadgetsLoadingWidget();
            case GadgetError(message: var message):
              return GadgetErrorWidget(message: message, onClick: _getGadgets);
            case GadgetLoaded(gadgets: var gadgets):
              return GadgetsListWidget(gadgets: gadgets);
            default:
              return Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
