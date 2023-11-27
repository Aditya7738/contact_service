import 'package:contact_service/src/core/constant/strings.dart';


class ValidationHelper{

  static String? checkIsNullOrEmpty(String? inputText){

    if(inputText == null || inputText.trim().isEmpty){
      return Strings.fieldEmptyMsg;
    }
    return null;

  }


  static String? validatePhone(String? phoneNumber) {

    String? nullablePhone = checkIsNullOrEmpty(phoneNumber);

    if (nullablePhone != null) {
      return nullablePhone;
    }

    bool isValidPhone = RegExp(r'^\d{10}$').hasMatch(phoneNumber!);

    if (!isValidPhone) {
      return Strings.phoneError;
    }
    return null;
  }


  static String? validateDisplayName(String? name) {
    String? nullableName = checkIsNullOrEmpty(name);
    if (nullableName != null) {
      return nullableName;
    }

    if (name!.length <= 3) {
      return Strings.nameError;
    }

    return null;
  }

  static String? validateFamilyName(String? name) {
    String? nullableName = checkIsNullOrEmpty(name);
    if (nullableName != null) {
      return nullableName;
    }

    if (name!.length <= 3) {
      return Strings.nameError;
    }

    return null;
  }





}