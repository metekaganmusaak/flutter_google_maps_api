import 'package:get_storage/get_storage.dart';

class LanguageServices{
  final _getStorage = GetStorage();
  final storageKey = 'whichLanguage';

  void saveLanguage(String language){
    _getStorage.write(storageKey, language );
  }

  String getLanguage(){
    if(isSavedLanguage().toString() == "en_US"){
      return "en_US";
    }
    else if(isSavedLanguage().toString() == "de_DE"){
      return "de_DE";
    }
    else{
      return "tr_TR";
    }
  }

  isSavedLanguage(){
    return _getStorage.read(storageKey) ?? false;
  }

  changeLanguage(){
    
  }







}