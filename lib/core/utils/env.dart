import 'package:envied/envied.dart';

part 'env.g.dart';

//Here you can specify the path to your .env file
//  relative to the project root
@Envied(path: '.env')
abstract class Env {
  //The ofuscate flag lets you make your variables more
  // secure through obfuscation
  @EnviedField(varName: 'OPENAIKEY', obfuscate: true)
  static final String openAIKey = _Env.openAIKey;
}
