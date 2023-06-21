import 'package:chatgpt/utils/img_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            icon: const Icon(Icons.fiber_smart_record),
            label: const Text('Icon'),
          ),
        ],
      ),
    );
  }
}
