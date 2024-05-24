// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const MESSAGE = _Paths.MESSAGE;
  static const COUNTER = _Paths.COUNTER;
  static const POST = _Paths.POST;
  static const USER = _Paths.USER;
  static const WEATHER = _Paths.WEATHER;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const MESSAGE = '/message';
  static const COUNTER = '/counter';
  static const POST = '/post';
  static const USER = '/user';
  static const WEATHER = '/weather';
}
