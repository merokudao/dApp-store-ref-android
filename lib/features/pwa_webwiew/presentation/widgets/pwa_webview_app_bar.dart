import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/infrastructure/models/rpc_mapping.dart';
import 'package:dappstore/features/pwa_webwiew/presentation/widgets/pop_up_menu.dart';
import 'package:dappstore/widgets/white_gradient_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef NavigationCallback = Function();

// ignore: must_be_immutable
class PwaAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates the appbar for PWA screen
  final String title;
  final IThemeSpec theme;
  NavigationCallback forward;
  NavigationCallback backwards;
  NavigationCallback reload;
  NavigationCallback clearCache;
  IPwaWebviewHandler handler;
  int? progress;
  PwaAppBar({
    Key? key,
    required this.title,
    required this.theme,
    required this.forward,
    required this.backwards,
    required this.reload,
    required this.clearCache,
    required this.handler,
    this.progress,
  }) : super(key: key);

  @override
  State<PwaAppBar> createState() => _PwaAppBarState();
  @override
  final Size preferredSize = const Size.fromHeight(64.0);
}

class _PwaAppBarState extends State<PwaAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: widget.theme.appBarBackgroundColor,
      leading: InkWell(
        onTap: context.popRoute,
        child: Icon(
          Icons.close,
          color: widget.theme.whiteColor,
        ),
      ),
      title: BlocBuilder<IInjectedWeb3Cubit, InjectedWeb3State>(
          bloc: widget.handler.injectedWeb3Cubit,
          builder: (context, state) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                    color: widget.theme.backgroundCardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: widget.theme.whiteColor)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (widget.progress != 0 &&
                                widget.progress != 100 &&
                                widget.progress != null)
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator.adaptive(
                                  // value: controller.value,
                                  valueColor:
                                      AlwaysStoppedAnimation(widget.theme.blue),
                                  backgroundColor: widget.theme.greyBlue,
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  widget.handler.showNetworkSwitch(context);
                                },
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: widget.theme.whiteColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          100,
                                        ),
                                      ),
                                    ),
                                    child: Image.asset(RpcMapping
                                        .networks[state.connectedChainId]!
                                        .icon),
                                  ),
                                ),
                              ),
                        Text(
                          widget.title,
                          style: widget.theme.titleTextExtraBold,
                        ),
                        InkWell(
                          onTap: () {
                            widget.reload();
                          },
                          child: Icon(
                            Icons.replay_outlined,
                            color: widget.theme.whiteColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      actions: [
        PwaWebViewPopupMenu(
          theme: widget.theme,
          forward: widget.forward,
          backwards: widget.backwards,
          reload: widget.reload,
          clearCache: widget.clearCache,
        )
      ],
      bottom: const WhiteGradientLine(),
    );
  }
}
