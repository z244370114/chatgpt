// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Chat Ai`
  String get title {
    return Intl.message(
      'Chat Ai',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Hello! Welcome to chat with me.`
  String get sayHello {
    return Intl.message(
      'Hello! Welcome to chat with me.',
      name: 'sayHello',
      desc: '',
      args: [],
    );
  }

  /// `NetWork node`
  String get netWorkNode {
    return Intl.message(
      'NetWork node',
      name: 'netWorkNode',
      desc: '',
      args: [],
    );
  }

  /// `Use your own key`
  String get useKey {
    return Intl.message(
      'Use your own key',
      name: 'useKey',
      desc: '',
      args: [],
    );
  }

  /// `Privacy agreement`
  String get privacyAgreement {
    return Intl.message(
      'Privacy agreement',
      name: 'privacyAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Please enter what you want to say`
  String get inputHit {
    return Intl.message(
      'Please enter what you want to say',
      name: 'inputHit',
      desc: '',
      args: [],
    );
  }

  /// `prompt`
  String get prompt {
    return Intl.message(
      'prompt',
      name: 'prompt',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Go to the registration key`
  String get skipKeyUrl {
    return Intl.message(
      'Go to the registration key',
      name: 'skipKeyUrl',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your own key`
  String get myselfKey {
    return Intl.message(
      'Please enter your own key',
      name: 'myselfKey',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Empty the cache`
  String get clearCache {
    return Intl.message(
      'Empty the cache',
      name: 'clearCache',
      desc: '',
      args: [],
    );
  }

  /// `agree`
  String get agree {
    return Intl.message(
      'agree',
      name: 'agree',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get userAgreement {
    return Intl.message(
      'User Agreement',
      name: 'userAgreement',
      desc: '',
      args: [],
    );
  }

  /// `Please read carefully before using the Chat Robot-AI service`
  String get user1 {
    return Intl.message(
      'Please read carefully before using the Chat Robot-AI service',
      name: 'user1',
      desc: '',
      args: [],
    );
  }

  /// `, after you agree and accept all the terms before starting to use our services, we hereby explain to you as follows:`
  String get user2 {
    return Intl.message(
      ', after you agree and accept all the terms before starting to use our services, we hereby explain to you as follows:',
      name: 'user2',
      desc: '',
      args: [],
    );
  }

  /// `1. In order to provide you with basic functions related to login, we will collect and use necessary information; 2. Based on your express authorization, we may obtain your mobile phone number, SMS (to provide you with login function), device number information (to ensure the security of your account), camera album (to upload personal avatars and pictures) and other information, and you have the right to refuse or cancel authorization; 3. We will take industry-advanced security measures to protect your information security; 4. We will not obtain, share or provide your information from third parties without your consent; 5. You can inquire, correct and delete your personal information, and we also provide channels for account cancellation.`
  String get user3 {
    return Intl.message(
      '1. In order to provide you with basic functions related to login, we will collect and use necessary information; 2. Based on your express authorization, we may obtain your mobile phone number, SMS (to provide you with login function), device number information (to ensure the security of your account), camera album (to upload personal avatars and pictures) and other information, and you have the right to refuse or cancel authorization; 3. We will take industry-advanced security measures to protect your information security; 4. We will not obtain, share or provide your information from third parties without your consent; 5. You can inquire, correct and delete your personal information, and we also provide channels for account cancellation.',
      name: 'user3',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
