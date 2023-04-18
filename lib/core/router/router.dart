import 'package:dappstore/core/router/interface/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension Router on BuildContext {
  Future<T?> pushRoute<T extends Object?>(Screen screen) {
    return Navigator.of(this).push<T>(MaterialPageRoute(
      builder: (_) => screen,
      settings: RouteSettings(name: screen.route),
    ));
  }

  Future<T?> pushNamedRoute<T extends Object?>(String screen) {
    return Navigator.of(this).pushNamed<T>(screen);
  }

  Future<T?> replaceRoute<T extends Object?, TO extends Object?>(
    Screen screen, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      CupertinoPageRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: screen.route),
      ),
      result: result,
    );
  }

  Future<T?> pushAndPopUntilRoot<T extends Object?>(Screen screen) {
    return Navigator.of(this).pushAndRemoveUntil<T>(
      CupertinoPageRoute(
        builder: (_) => screen,
        settings: RouteSettings(name: screen.route),
      ),
      (_) => false,
    );
  }

  void popUntilRoute<T extends Object?>(Screen screen) {
    return Navigator.of(this).popUntil(ModalRoute.withName(screen.route));
  }

  void popRoute<T extends Object?>([T? result]) {
    return Navigator.pop<T>(this, result);
  }
}

extension ToRouteSettings on String {
  RouteSettings get toRouteSettings {
    return RouteSettings(name: this);
  }
}
