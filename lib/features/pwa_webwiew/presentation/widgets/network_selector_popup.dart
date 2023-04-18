import 'package:dappstore/core/localisation/localisation_extension.dart';
import 'package:dappstore/core/router/router.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/pwa_webwiew/application/handler/i_pwa_webview_handler.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/i_injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/application/injected_web3_cubit/injected_web3_cubit.dart';
import 'package:dappstore/features/pwa_webwiew/infrastructure/models/rpc_mapping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkSelectorPopup extends StatelessWidget {
  /// Creates network slector popup, used in PWa screen appbar
  final IThemeSpec theme;
  final IPwaWebviewHandler handler;
  const NetworkSelectorPopup(
      {super.key, required this.theme, required this.handler});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<IInjectedWeb3Cubit, InjectedWeb3State>(
          bloc: handler.injectedWeb3Cubit,
          buildWhen: (previous, current) =>
              previous.connectedChainId != current.connectedChainId,
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  context.getLocale!.selectNetwork,
                  style: theme.titleTextStyle,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: RpcMapping.networks.length,
                    itemBuilder: (context, index) {
                      final k = RpcMapping.networks.keys.toList()[index];
                      return InkWell(
                        onTap: () {
                          handler.changeChains(k);
                          context.popRoute();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: SizedBox(
                              width: 42,
                              height: 42,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.whiteColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      100,
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    RpcMapping.networks[k]!.icon,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              RpcMapping.networks[k]!.name,
                              style: theme.normalTextStyle,
                            ),
                            trailing: state.connectedChainId == k
                                ? Icon(
                                    Icons.check_circle,
                                    color: theme.appGreen,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      );
                    }),
              ],
            );
          }),
    );
  }
}
