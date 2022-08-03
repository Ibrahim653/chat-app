import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static  const  userNameKey="UserNameKey";
  static  const  userIdKey="userKey";
  static  const  displayNameKey="UserDisplayNameKey";
  static  const  userEmailKey="UserEmailKey";
  static  const  userProfileKey="UserProfileKey";
//save data
Future<bool> saveUserName(String getUserName)async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return prefs.setString(userNameKey, getUserName);
}

  Future<bool> saveUserID(String getUserId)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveUserEmail(String getUserEmail)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserEmail);
  }

  Future<bool> saveUserDisplayName(String getUserDisplayName)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserDisplayName);
  }

  Future<bool> saveUserProfileUrl(String getUserProfile)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserProfile);
  }


}