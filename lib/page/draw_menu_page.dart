import 'package:chatgpt/utils/img_util.dart';
import 'package:chatgpt/widgets/web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/api_url.dart';
import '../network/dio_utils.dart';

class DrawMenuPage extends StatefulWidget {
  const DrawMenuPage({Key? key}) : super(key: key);

  @override
  _DrawMenuPageState createState() => _DrawMenuPageState();
}

class _DrawMenuPageState extends State<DrawMenuPage> {
  final List _listTitle = [
    {
      "title": "Share App",
      "icon": "",
      "content": "",
      "link": "",
    },
    {
      "title": "Goolge Play",
      "icon": "",
      "content": "",
      "link": "",
    },
    {
      "title": "About Us",
      "icon": "",
      "content": "",
      "link": "",
    },
  ];

  final TextEditingController _controllerKey = TextEditingController();
  final Uri _url = Uri.parse('https://openai.com/blog/chatgpt');

  final getStorage = GetStorage("zyChatGpt");

  @override
  Widget build(BuildContext context) {
    _controllerKey.text = getStorage.read("chatGptKey") ?? "";
    return Container(
      padding: EdgeInsets.only(
          top: MediaQueryData.fromView(
                  WidgetsBinding.instance.platformDispatcher.views.first)
              .padding
              .top),
      child: Column(
        children: [
          Image.asset(
            ImgUtil.getImgPath('chatgpt_logo'),
            fit: BoxFit.cover,
            width: 128.w,
            height: 128.w,
          ),
          SizedBox(height: 20.w),
          Image.asset(
            ImgUtil.getImgPath('chatgpt_bg', format: "webp"),
            fit: BoxFit.fitWidth,
            width: 380.w,
            height: 200.w,
          ),
          SizedBox(height: 20.w),
          TextButton.icon(
            onPressed: () {
              openDialog(context);
            },
            icon: const Icon(Icons.update_sharp),
            label: const Text('Use your own key'),
          ),
          SizedBox(height: 20.w),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WebPage(title: "Privacy Agreement",)));
            },
            icon: const Icon(Icons.privacy_tip),
            label: const Text('Privacy Agreement '),
          ),
          SizedBox(height: 20.w),
          // TextButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(Icons.abc_rounded),
          //   label: const Text('About Us'),
          // ),
        ],
      ),
    );
  }

  void openDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controllerKey,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.key),
                hintText: 'Please enter your own key',
                filled: true,
              ),
            ),
            TextButton(
              onPressed: () {
                launchUrl(_url);
              },
              child: const Text(
                "Go to the registration key",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FilledButton(
            child: const Text('Okay'),
            onPressed: () {
              var content = _controllerKey.text;
              if (content.contains("sk")) {
                getStorage.write("chatGptKey", content);
                Navigator.of(context).pop();
              } else {
                // Sorry there is an exception in the key you entered
              }
            },
          ),
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  saveKey() {
    DioUtils.instance.requestNetwork(
        Method.get, "${ApiUrl.saveKey}${_controllerKey.text}",
        onSuccess: (data) {}, onError: (code, msg) {});
  }
}
