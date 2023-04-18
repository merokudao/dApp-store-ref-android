import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/get_dapp_info_query_dto.g.dart';

@freezed
class GetDappInfoQueryDto with _$GetDappInfoQueryDto {
  const GetDappInfoQueryDto._();

  factory GetDappInfoQueryDto({
    String? dappId,
  }) = _GetDappInfoQueryDto;
  factory GetDappInfoQueryDto.fromJson(Map<String, Object?> json) =>
      _$GetDappInfoQueryDtoFromJson(json);

  toDomain() => GetDappInfoQueryDto();
}
