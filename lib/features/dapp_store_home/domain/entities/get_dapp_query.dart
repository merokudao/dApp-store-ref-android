import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/domain/entities/get_dapp_query.freezed.dart';
part '../../../../generated/features/dapp_store_home/domain/entities/get_dapp_query.g.dart';

@freezed
class GetDappQuery with _$GetDappQuery {
  factory GetDappQuery({
    List<String?>? allowedInCountries,
    List<String?>? availableOnPlatform,
    List<String?>? blockedInCountries,
    List<String?>? categories,
    int? chainId,
    bool? isListed,
    String? language,
    int? limit,
    String? listedOnOrAfter,
    String? listedOnOrBefore,
    bool? matureForAudience,
    int? minAge,
    int? page,
    String? search,
  }) = _GetDappQuery;
  factory GetDappQuery.fromJson(Map<String, Object?> json) =>
      _$GetDappQueryFromJson(json);
}
