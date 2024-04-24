import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_path_provider/models/note_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void infoDialog({required BuildContext context, required NoteModel noteModel}) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    content: SizedBox(
      height: 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text("Note info",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 15),
          ZoomTapAnimation(
            onLongTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                const Icon(Icons.folder, color: Colors.blue),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(noteModel.name, maxLines: 1, overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            child: Row(
              children: [
                const Icon(Icons.date_range, color: Colors.green),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(noteModel.createDate, maxLines: 1, overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            child: Row(
              children: [
                const Icon(Icons.update, color: Colors.red),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(noteModel.updateDate, maxLines: 1, overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () => _openPhone(context),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/call.svg',
                    width: 20,
                    height: 20,
                    // ignore: deprecated_member_use
                    color: Colors.green
                ),
                const SizedBox(width: 10),
                const Expanded(child: Text("Qo'ng'iroq qilish"))
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () => _openTelegram(context),
            child: Row(
              children: [
                SvgPicture.asset(
                    'assets/icons/telegram.svg',
                    width: 20,
                    height: 20,
                    // ignore: deprecated_member_use
                    color: Colors.blue
                ),
                const SizedBox(width: 10),
                const Expanded(child: Text("Telegrmdan yozish")),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () => Clipboard.setData(ClipboardData(text: noteModel.name)),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/copy.svg', width: 20, height: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text("Copy name", maxLines: 1, overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 35),
            child: Divider(),
          ),
          ZoomTapAnimation(
            onTap: () => Clipboard.setData(ClipboardData(text: noteModel.note)),
            child: Row(
              children: [
                SvgPicture.asset('assets/icons/copy.svg', width: 20, height: 20),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text("Copy note", maxLines: 1, overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          const Spacer(),
          ZoomTapAnimation(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8)
              ),
              child: const Text("Yopish"),
            ),
          )
        ],
      ),
    ),
  )
);

void _openPhone(BuildContext context) async {
  String url = 'tel:+998916884460';
  // ignore: deprecated_member_use
  if (await canLaunch(url)){
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    if(!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Telefon raqamini chaqirish uchun URL ochilmadi: $url")
        )
    );
  }
}

void _openTelegram(BuildContext context) async {
  try{
    // ignore: deprecated_member_use
    await launch("https://t.me/diyorbekqurbonov");
  } catch(e){
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Telegramni ochish uchun URL ochilmadi: https://t.me/diyorbekqurbonov")
      )
    );
  }
}
