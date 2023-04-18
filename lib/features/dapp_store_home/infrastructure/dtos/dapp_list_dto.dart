import 'package:dappstore/features/dapp_store_home/domain/entities/dapp_list.dart';
import 'package:dappstore/features/dapp_store_home/infrastructure/dtos/dapp_info_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/dapp_list_dto.g.dart';

@freezed
class DappListDto with _$DappListDto {
  const DappListDto._();
  const factory DappListDto({
    int? page,
    int? limit,
    int? pageCount,
    List<DappInfoDto?>? response,
  }) = _DappListDto;
  factory DappListDto.fromJson(Map<String, Object?> json) =>
      _$DappListDtoFromJson(json);

  toDomain() => DappList.fromJson(toJson());
}
