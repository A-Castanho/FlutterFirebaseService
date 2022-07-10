import 'package:reflectable/reflectable.dart';
import 'package:reflectable/mirrors.dart';

const reflector = const Reflector();

class Reflector extends Reflectable
{
  const Reflector() : super(
    invokingCapability,
    typingCapability,
    reflectedTypeCapability,
  );
}


@reflector
 abstract class DataEntry{

  ///Sets the instane's value fromthe json data
  dynamic setFromJson(Map<String, dynamic> json){
    Id = json["Id"];
  }

  late String Id;

  /// Returns the json with the value of every value of the instance without the Id.
  /// This is the format used to send the value to the Firebase Database.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json= <String,dynamic>{};
    TypeMirror typeMirror = reflector.reflectType(this.runtimeType);
    InstanceMirror instanceMirror = reflector.reflect(this);
    typeMirror.typeVariables.forEach((typeVariable) {
      var key = json[typeVariable.simpleName];
      if(key!="Id"){
        var value = instanceMirror.invokeGetter(key);
        json[key] = value;
      }
    });
    return json;
  }

}

abstract class Animal{
  static dynamic getBreath(){}
}

class Dog extends Animal{
  static dynamic getBreath(){
    return "Bop";
  }
}