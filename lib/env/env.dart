import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(
      varName: 'GOOGLE_MAPS_KEY', obfuscate: true, useConstantCase: true)
  static final String googleMapsKey = _Env.googleMapsKey;
}
