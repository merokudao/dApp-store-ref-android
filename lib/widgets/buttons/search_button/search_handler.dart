import 'package:dappstore/core/di/di.dart';
import 'package:dappstore/core/theme/i_theme_cubit.dart';
import 'package:dappstore/core/theme/theme_specs/i_theme_spec.dart';
import 'package:dappstore/features/dapp_store_home/application/store_cubit/i_store_cubit.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.dart';
import 'package:dappstore/widgets/buttons/search_button/i_search_handler.dart';

class SearchHandler implements ISearchHandler {
  @override
  IStoreCubit get storeCubit => getIt<IStoreCubit>();

  @override
  IThemeSpec get theme => getIt<IThemeCubit>().theme;

  @override
  getSearchDappList({required GetDappQueryDto queryParams}) {
    storeCubit.getSearchDappList(queryParams: queryParams);
  }

  @override
  getSearchDappListNextPage() {
    storeCubit.getSearchDappListNextPage();
  }

  @override
  setActiveDappId({required String dappId}) {
    storeCubit.setActiveDappId(dappId: dappId);
  }
}
