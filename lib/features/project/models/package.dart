import 'package:freezed_annotation/freezed_annotation.dart';

part 'package.freezed.dart';

@freezed
class Package with _$Package {
  const Package._();

  const factory Package({
    required String name,
    String? version,
    String? url,
  }) = _Package;
}
