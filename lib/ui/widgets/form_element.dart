import 'package:flutter/material.dart';

class FormElementWithIcon extends StatelessWidget {
  final Widget child;
  final Widget trailing;
  final String label;
  final IconData icon;

  const FormElementWithIcon({this.child, this.trailing, this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 30.0, bottom: 12.0),
            child: Icon(icon)
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold),),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (child != null)
                  Expanded(child: child),
                  if (trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: trailing,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
