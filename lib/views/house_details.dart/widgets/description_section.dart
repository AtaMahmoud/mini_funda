import 'package:flutter/material.dart';

import '../../common_ui/spacer.dart';
import '../../common_ui/text_style.dart';

class DescriptionSection extends StatefulWidget {
  const DescriptionSection({required this.description, super.key});

  final String description;
  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: MiniFundaTextTheme.h1,
        ),
        HorizontalSpacer.xs(),
        Text(
          _isExpanded
              ? widget.description
              : "${widget.description.substring(0, 300)}...",
        ),
        HorizontalSpacer.xs(),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'See Less' : 'See More',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
