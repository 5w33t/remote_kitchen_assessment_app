import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData? icon;
  final Color? color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon ?? Icons.no_accounts,
        color: color,
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          text ?? "",
          overflow: TextOverflow.visible,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: color,
                fontSize: 14,
              ),
        ),
      ),
    ]);
  }
}
