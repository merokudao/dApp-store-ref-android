import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CustomRouteObserver extends NavigatorObserver {
  final List<String> _navHistory = [];
  String? _activeTab;

  String get currentPath => _navHistory.fold<String>(
      '', (previousValue, element) => previousValue + element);

  String get currentFullPath => _navHistory.fold<String>(
      '',
      (previousValue, element) =>
          previousValue +
          (element == '/home' && _activeTab != null
              ? '$element$_activeTab'
              : element));

  String routeName(Route<dynamic>? route) =>
      route == null ? 'null' : (route.settings.name ?? '/unnamed');

  void didChangeTab(String? tabName) {
    _activeTab = tabName;
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var navData = '${routeName(route)} >> ${routeName(previousRoute)}';
    if (previousRoute != null) {
      if (_navHistory.isEmpty) {
        navData += ' [ERR] Nav History Empty';
      } else if (routeName(route) != _navHistory.last) {
        navData += ' [ERR] Last Nav Route NA';
      }
    }
    _navHistory.removeLast();
    log('didPop $navData PATH: $currentFullPath', name: 'navigation');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var navData = '${routeName(previousRoute)} >> ${routeName(route)}';
    if (previousRoute != null) {
      if (_navHistory.isEmpty) {
        navData += ' [ERR] Nav History Empty';
      } else if (routeName(previousRoute) != _navHistory.last) {
        navData += ' [ERR] Last Nav Route NA';
      }
    }
    _navHistory.add(routeName(route));
    log('didPush $navData PATH: $currentFullPath', name: 'navigation');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    var navData = '${routeName(oldRoute)} >> ${routeName(newRoute)}';
    if (oldRoute == null) {
      navData += ' [ERR] Old Route NULL';
    }
    if (newRoute == null) {
      navData += ' [ERR] New Route NULL';
    }
    if (oldRoute != null && newRoute != null) {
      if (_navHistory.isEmpty) {
        navData += ' [ERR] Nav History Empty';
      } else if (routeName(oldRoute) != _navHistory.last) {
        navData += ' [ERR] Last Nav Route NA';
      } else {
        _navHistory
          ..removeLast()
          ..add(routeName(newRoute));
      }
    }
    log('didReplace $navData PATH: $currentFullPath', name: 'navigation');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    var navData = '${routeName(previousRoute)} >> ${routeName(route)}';
    final idx =
        _navHistory.lastIndexWhere((element) => element == routeName(route));
    if (idx >= 0) {
      _navHistory.removeAt(idx);
    } else {
      navData += ' [ERR] Route to remove NA';
    }
    log('didRemove $navData PATH: $currentFullPath', name: 'navigation');
  }
}
