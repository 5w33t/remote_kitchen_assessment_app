part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const MESSAGE = _Paths.MESSAGE;
  static const COUNTER = _Paths.COUNTER;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const MESSAGE = '/message';
  static const COUNTER = '/counter';
}
