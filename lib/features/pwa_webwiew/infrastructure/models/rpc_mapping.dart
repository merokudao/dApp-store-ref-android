import 'package:dappstore/features/pwa_webwiew/infrastructure/models/rpc_model.dart';
import 'package:dappstore/utils/icon_constants.dart';

class RpcMapping {
  static Map<int, RpcModel> get networks => {
        1: const RpcModel(
            rpc: "https://rpc.ankr.com/eth",
            name: "Ethereum",
            icon: IconConstants.ethereumIcon),
        137: const RpcModel(
            rpc: "https://rpc.ankr.com/polygon",
            name: "Polygon",
            icon: IconConstants.polygonIcon),
      };
}
