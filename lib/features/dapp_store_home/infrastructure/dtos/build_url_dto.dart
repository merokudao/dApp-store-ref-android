import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/build_url_dto.freezed.dart';
part '../../../../generated/features/dapp_store_home/infrastructure/dtos/build_url_dto.g.dart';

@freezed
class BuildUrlDto with _$BuildUrlDto {
  factory BuildUrlDto({
    String? url,
    bool? success,
  }) = _BuildUrlDto;
  factory BuildUrlDto.fromJson(Map<String, Object?> json) =>
      _$BuildUrlDtoFromJson(json);
}
