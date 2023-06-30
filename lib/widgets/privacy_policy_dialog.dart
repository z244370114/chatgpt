import 'package:chatgpt/widgets/web_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        child: IntrinsicHeight(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  S.of(context).userAgreement,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: S.of(context).user1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 1.3,
                        height: 1.5,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                      text: "《${S.of(context).userAgreement}》",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF537FB7),
                        fontSize: 14,
                        letterSpacing: 1.3,
                        height: 1.5,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebPage(
                                        title: S.of(context).userAgreement,
                                        url: "assets/agreenment_en.html",
                                      )));
                        }),
                  TextSpan(
                    text: S.of(context).and,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.3,
                        height: 1.5,
                        fontSize: 14,
                        decoration: TextDecoration.none),
                  ),
                  TextSpan(
                      text: "《${S.of(context).privacyAgreement}》",
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF537FB7),
                        fontSize: 14,
                        letterSpacing: 1.3,
                        height: 1.5,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebPage(
                                        title: S.of(context).privacyAgreement,
                                        url: "assets/privacy_en.html",
                                      )));
                        }),
                  TextSpan(
                    text: S.of(context).user2,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 1.3,
                        height: 1.5,
                        decoration: TextDecoration.none),
                  ),
                ])),
              ),
              Container(
                height: 240,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: S.of(context).user3,
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.3,
                              height: 1.5,
                              decoration: TextDecoration.none),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    child: Text(S.of(context).agree),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
