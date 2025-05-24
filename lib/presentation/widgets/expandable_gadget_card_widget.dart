import 'package:flutter/material.dart';

class ExpandableGadgetCardWidget extends StatefulWidget {
  final String title;
  final Map<String, dynamic> data;

  const ExpandableGadgetCardWidget({
    super.key,
    required this.title,
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
                        widget.title,
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
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '• ',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${entry.key}: ${entry.value}',
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
