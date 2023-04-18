import 'package:flutter/cupertino.dart';

abstract class Screen extends Widget {
  const Screen({super.key});

  String get route;
}

abstract class StatefulScreen extends StatefulWidget implements Screen {
  const StatefulScreen({Key? key}) : super(key: key);

  @override
  String get route;
}

abstract class StatelessScreen extends StatelessWidget implements Screen {
  const StatelessScreen({Key? key}) : super(key: key);

  @override
  String get route;
}
