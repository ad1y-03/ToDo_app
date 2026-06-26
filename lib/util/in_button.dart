import 'package:flutter/material.dart';


class InButton extends StatelessWidget {

  final String buttname;
  final void Function() onPressed;

  const InButton({super.key,
    required this.buttname,
    required this.onPressed,
  });


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(buttname),);
  }
}
