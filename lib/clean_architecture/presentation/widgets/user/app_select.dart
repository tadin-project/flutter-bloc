import 'package:flutter/material.dart';

class AppSelect<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T? data)? onChanged;
  final T? value;

  const AppSelect({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
