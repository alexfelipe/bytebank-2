//TODO é normal usar DTO no Flutter?
class FeatureDto {
  final int id;

  FeatureDto(this.id,);

  FeatureDto.deJson(Map<String, dynamic> json)
      : id = json['id'];
}