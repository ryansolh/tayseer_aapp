
import'package:flutter/material.dart';
Future<void> alertDialog({required BuildContext context,required void Function()? onPressed}) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('لديك موعد لقاء طبيب بنفس هذا الموعد\n هل تريد المتابعة وإضافة الموعد؟'),
          title: const Text('ملاحظة:'),
          actions: <Widget>[
            TextButton(
              onPressed:onPressed,
              child: const Text('متابعة'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'تعديل');
              },
              child: const Text('تعديل'),
            ),
          ],
        );
      })) {
    case 'متابعة':
      break;
    case 'تعديل':
      break;
  }
}