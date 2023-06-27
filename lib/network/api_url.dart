class ApiUrl {
  static const app_config = "/api/config";

  /// 发送消息
  // static String sendUrL(int id, {String? key = ""}) {
  //   return key == "" ? '/openAi/chat/$id/' : '/openAi/chat/$id/$key/';
  // }


  /// 发送消息
  static const sendUrL = "/v1/chat/completions";

  static String saveKey = "/tApiKey/save/";
}
