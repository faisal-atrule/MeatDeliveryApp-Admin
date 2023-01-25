import 'package:flutter/material.dart';

Widget subTotalWidget({
  required BuildContext context,
  required String title,
  required String value,
  required bool prominentLeft, prominentRight
}){
  return IntrinsicHeight(
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: SizedBox(
            height: double.infinity,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: prominentLeft ?
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold) :
              Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: SizedBox(
            height: double.infinity,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: prominentRight ?
              Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold) :
              Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        )
      ],
    ),
  );
}