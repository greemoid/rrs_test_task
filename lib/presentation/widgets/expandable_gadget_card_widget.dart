import 'package:flutter/material.dart';
import 'package:rrs_test_task/core/extensions/string_casing_extension.dart';

import '../utils/get_color_from_name.dart';

class ExpandableGadgetCardWidget extends StatefulWidget {
  final String name;
  final Map<String, dynamic> data;

  const ExpandableGadgetCardWidget({
    super.key,
    required this.name,
    required this.data,
  });

  @override
  State<ExpandableGadgetCardWidget> createState() =>
      _ExpandableGadgetCardWidgetState();
}

class _ExpandableGadgetCardWidgetState
    extends State<ExpandableGadgetCardWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: const Icon(Icons.expand_more),
                ),
              ],
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 300),
              child: _isExpanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: widget.data.isEmpty
                          ? Text(
                              'Sorry, we do not have any information about this gadget',
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.data.entries.map((entry) {
                                final key = entry.key.capitalize();
                                final value = entry.value.toString();
                                final isColorField = key.toLowerCase().contains(
                                  'color',
                                );
                                final colorValue = getColorFromName(value);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (isColorField && colorValue != null)
                                        Row(
                                          children: [
                                            Text(
                                              '$key: ',
                                              style: theme.textTheme.bodyMedium,
                                            ),
                                            Container(
                                              width: 16,
                                              height: 16,
                                              margin: const EdgeInsets.only(
                                                left: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorValue,
                                                border: Border.all(
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      else
                                        Expanded(
                                          child: Text(
                                            '$key: $value',
                                            style: theme.textTheme.bodyMedium,
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
