import 'package:bloc/bloc.dart';
import 'package:dappstore/core/platform_channel/constants/constants.dart';
import 'package:dappstore/core/platform_channel/i_platform_channel_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part '../../generated/core/platform_channel/platform_channel_cubit.freezed.dart';
part 'platform_channel_state.dart';

@LazySingleton(as: IPlatformChannelCubit)
class PlatformChannelCubit extends Cubit<PlatformChannelState>
    implements IPlatformChannelCubit {
  late MethodChannel platform;
  PlatformChannelCubit() : super(PlatformChannelState.initial()) {
    platform = const MethodChannel(PlatformChannelConstants.channelName);
  }
  @override
  Future<dynamic> call(String method, List<dynamic> args) async {
    final result = await platform.invokeMethod(
      method,
      args,
    );
    debugPrint("Result: $result");
    return result;
  }
}
