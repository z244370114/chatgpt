import 'package:chatgpt/utils/img_util.dart';
import 'package:chatgpt/widgets/web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/l10n.dart';
import '../network/api_url.dart';
import '../network/dio_utils.dart';

class DrawMenuPage extends StatefulWidget {
  final Function onClick;

  const DrawMenuPage({
    Key? key,
    required this.onClick,
  }) : super(key: key);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              ImgUtil.getImgPath('chatgpt_logo'),
              fit: BoxFit.cover,
              width: 128.w,
              height: 128.w,
            ),
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
            label: Text(S.of(context).useKey),
          ),
          SizedBox(height: 20.w),
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebPage(
                            title: S.of(context).privacyAgreement,
                            url: "assets/privacy_en.html",
                          )));
            },
            icon: const Icon(Icons.privacy_tip),
            label: Text(S.of(context).privacyAgreement),
          ),
          SizedBox(height: 20.w),
          TextButton.icon(
            onPressed: () {
              getStorage.remove('choicesModel');
              widget.onClick();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.cleaning_services_rounded),
            label: Text(S.of(context).clearCache),
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
        title: Text(S.of(context).prompt),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerKey,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                prefixIcon: const Icon(Icons.key),
                hintText: S.of(context).myselfKey,
                hintStyle: TextStyle(
                  fontSize: 24.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                launchUrl(_url);
              },
              child: Text(
                S.of(context).skipKeyUrl,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FilledButton(
            child: Text(S.of(context).ok),
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
            child: Text(S.of(context).close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  saveKey() {
    DioUtils.instance.requestNetwork(Method.get, ApiUrl.saveKey,
        queryParameters: {'key': _controllerKey.text},
        onSuccess: (data) {},
        onError: (code, msg) {});
  }
}
