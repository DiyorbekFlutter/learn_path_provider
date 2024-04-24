import 'package:flutter/material.dart';

void deleteDialog({required BuildContext context, required String noteName, required void Function() delete}) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$noteName o'chirilsinmi?",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: delete,
              // child: const Text("O'chirilsin"),
              child: const Text("Qaytish yo'q 😜"),
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
