import 'package:dappstore/features/dapp_store_home/domain/entities/get_dapp_query.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/get_dapp_query_dto.g.dart';

@freezed
class GetDappQueryDto with _$GetDappQueryDto {
  const GetDappQueryDto._();

  factory GetDappQueryDto({
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
  }) = _GetDappQueryDto;
  factory GetDappQueryDto.fromJson(Map<String, Object?> json) =>
      _$GetDappQueryDtoFromJson(json);

  toDomain() => GetDappQuery();
}
