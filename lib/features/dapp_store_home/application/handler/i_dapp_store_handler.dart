import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/features/saved_dapps/application/i_saved_dapps_cubit.dart';
import 'package:dappstore/features/self_update/application/cubit/i_self_update_cubit.dart';
import 'package:dappstore/widgets/buttons/search_button/i_search_handler.dart';

abstract class IDappStoreHandler implements ISearchHandler {
  ISavedDappsCubit get savedDappsCubit;

  ISelfUpdateCubit get selfUpdateCubit;

  IStoreCubit getStoreCubit();
  @override
  IThemeSpec get theme;

  started();
  getDappList();

  getDappListNextPage();

  getDappInfo({GetDappInfoQueryDto? queryParams});

  getCuratedList();
  @override
  getSearchDappList({required GetDappQueryDto queryParams});

  @override
  getSearchDappListNextPage();

  getCuratedCategoryList();

  getFeaturedDappsList();

  getFeaturedDappsByCategory({required String category});

  getSelectedCategoryDappList({required GetDappQueryDto queryParams});

  getSelectedCategoryDappListNextPage();

  resetSelectedCategory();
  @override
  setActiveDappId({required String dappId});
}
