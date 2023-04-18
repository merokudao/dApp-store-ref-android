import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';

abstract class ISearchHandler {
  IStoreCubit get storeCubit;

  IThemeSpec get theme;

  getSearchDappList({required GetDappQueryDto queryParams});

  getSearchDappListNextPage();

  setActiveDappId({required String dappId});
}
