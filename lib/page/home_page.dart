import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:chatgpt/network/api_url.dart';
import 'package:chatgpt/network/dio_utils.dart';
import 'package:chatgpt/network/model/chat_model.dart';
import 'package:chatgpt/page/draw_menu_page.dart';
import 'package:chatgpt/resoure/zcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../generated/l10n.dart';
import '../utils/img_util.dart';
import '../widgets/markdown/markdown_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _homeStateKey = GlobalKey<ScaffoldState>();

  final _commentFocus = FocusNode();
  final _etController = TextEditingController();
  final _listController = ScrollController();

  final List<Choices> _choicesModel = [];

  final getStorage = GetStorage("zyChatGpt");
  var node = 0;
  var sendLoading = true;

  @override
  void initState() {
    super.initState();
    _listController.addListener(() {
      _commentFocus.unfocus();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _listController.jumpTo(_listController.position.maxScrollExtent);
    });

    initListItem();
  }

  void initListItem() {
    var listItem = getStorage.read("choicesModel");
    if (getStorage.read("node") == null) {
      node = 0;
    } else {
      node = getStorage.read("node");
    }

    if (listItem != null) {
      for (var item in listItem) {
        _choicesModel.add(Choices.fromJson(item));
      }
    } else {
      _choicesModel.add(Choices(
          message: Message(
              role: "assistant", content: "Hello! Welcome to chat with me.")));
      getStorage.write("choicesModel", _choicesModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      child: Scaffold(
          key: _homeStateKey,
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: false,
          drawerEnableOpenDragGesture: true,
          drawer: SizedBox(
            width: 400.w,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const DrawMenuPage(),
            ),
          ),
          body: bodyWidget()),
      onWillPop: () {
        return Future(() => true);
      },
    );
  }

  bodyWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).title,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            _commentFocus.unfocus();
            _homeStateKey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu),
        ),
        actions: [
          rightMenu(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _listController,
              padding: const EdgeInsets.all(0),
              itemCount: _choicesModel.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                final item = _choicesModel[index];
                if (item.message?.role == "user") {
                  return rightWidget(item.message!);
                } else {
                  return leftWidget(item.message!);
                }
              },
            ),
          ),
          Container(
            color: Colors.white,
            height: 120.w,
            padding: EdgeInsets.fromLTRB(24.w, 10.w, 10.w, 10.w),
            child: TextField(
              controller: _etController,
              focusNode: _commentFocus,
              decoration: InputDecoration(
                hintText: S.of(context).inputHit,
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_etController.text == "") return;
                    sendContent();
                    _commentFocus.unfocus();
                  },
                  icon: Icon(sendLoading ? Icons.send : Icons.send_outlined),
                ),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  rightMenu() {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: MenuAnchor(
        builder: (context, controller, child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.switch_access_shortcut),
          );
        },
        menuChildren: [
          MenuItemButton(
            child: Text('${S.of(context).netWorkNode} 1'),
            onPressed: () {
              getStorage.write("node", 0);
              node = 0;
            },
          ),
          MenuItemButton(
            child: Text('${S.of(context).netWorkNode} 2'),
            onPressed: () {
              getStorage.write("node", 1);
              node = 1;
            },
          ),
          MenuItemButton(
            child: Text('${S.of(context).netWorkNode} 3'),
            onPressed: () {
              getStorage.write("node", 2);
              node = 2;
            },
          ),
        ],
      ),
    );
  }

  leftWidget(Message message) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10.w, 10.w, 0, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Image.asset(
              'assets/images/icon_ai.gif',
              width: 64.w,
              height: 64.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Flexible(
          child: Container(
            margin: EdgeInsets.fromLTRB(20.w, 10.w, 94.w, 10.w),
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: MarkdownWidget(
              markdownData: message.content!.trim(),
            ),
          ),
        ),
      ],
    );
  }

  rightWidget(Message message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.fromLTRB(94.w, 10.w, 20.w, 10.w),
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.w),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10.r))),
            child: Text(
              message.content!,
              style: TextStyle(color: ZColor.wihte, fontSize: 30.sp),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 10.w, 10.w, 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Image.asset(
              ImgUtil.getImgPath('icon_man_avatar', format: 'gif'),
              width: 64.w,
              height: 64.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  snackBar(content) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      width: 400.0,
      content: Text(content),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  sendContent() {
    setState(() {
      sendLoading = false;
      _choicesModel.add(
          Choices(message: Message(role: "user", content: _etController.text)));
      _listController.jumpTo(_listController.position.maxScrollExtent);
    });

    // var params = {
    //   "model": "gpt-3.5-turbo",
    //   "messages": [
    //     {
    //       "role": "user",
    //       "content": _etController.text,
    //     }
    //   ],
    //   "temperature": 0.7
    // };
    var content = _etController.text;
    _etController.text = "";

    DioUtils.instance.requestNetwork(
        Method.get, '${ApiUrl.sendUrL(node)}$content', onSuccess: (data) {
      var chatModel = ChatModel.fromJson(json.decode(data.toString()));
      var choices = chatModel.choices?[0];
      _choicesModel.add(choices!);
      setState(() {
        sendLoading = true;
        Timer.periodic(const Duration(milliseconds: 200), (timer) {
          _listController.jumpTo(_listController.position.maxScrollExtent);
          timer.cancel();
        });
      });
      getStorage.write("choicesModel", _choicesModel);
    }, onError: (code, msg) {
      setState(() {
        sendLoading = true;
      });
      snackBar(msg);
      getStorage.write("choicesModel", _choicesModel);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
