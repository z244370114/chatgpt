import 'package:chatgpt/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

main() async {
  await GetStorage.init("zyChatGpt")
      .then((value) => {runApp(const MainPage())});
}
