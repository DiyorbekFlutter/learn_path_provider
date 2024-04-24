import 'package:flutter/material.dart';

void warningAlertDialog({required BuildContext context, required void Function() save}) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Malumotlar to'liq yozilmagan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: save,
              child: const Text("Baribir saqlash"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Bekor qilish"),
            ),
          ],
        )
      ],
    ),
  ),
);
