import 'package:flutter/material.dart';

bool warningDialog({required BuildContext context, required void Function() saveAndBack}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Malumotlarni saqlamagansiz", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: saveAndBack,
                child: const Text("Saqlash va chiqish"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Qaytish"),
              ),
            ],
          )
        ],
      ),
    ),
  );



  return false;
}
