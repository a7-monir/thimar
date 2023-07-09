import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{

  static late SharedPreferences _preferences;

  static init() async{
    _preferences =await SharedPreferences.getInstance();
  }

  static setUserId(int id) async {
    await _preferences.setInt("user_id", id);
  }
  static int getUserId() {
    return _preferences.getInt("user_id")??0;
  }
  static setFullName(String fullName) async {
    await _preferences.setString("fullname", fullName);
  }

  static String getFullName() {
    return _preferences.getString("fullname") ?? "";
  }
  static setPhone(String phone) async {
    await _preferences.setString("phone", phone);
  }

  static String getPhone() {
    return _preferences.getString("phone") ?? "";
  }
  static setEmail(String email) async {
    await _preferences.setString("email", email);
  }

  static String getEmail() {
    return _preferences.getString("email") ?? "";
  }
  static setImage(String image) async {
    await _preferences.setString("image", image);
  }

  static String getImage() {
    return _preferences.getString("image") ?? "";
  }
  static setIsBan(int isBan) async {
    await _preferences.setInt("isBan", isBan);
  }

  static int getIsBan() {
    return _preferences.getInt("isBan") ?? 0;
  }
  static setIsActive(bool value) async {
    await _preferences.setBool("isActive", value);
  }

  static bool getIIsActive() {
    return _preferences.getBool("isActive") ?? false;
  }
  static setUnreadNotifications(int unreadNotifications) async {
    await _preferences.setInt("unreadNotifications", unreadNotifications);
  }

  static int getUnreadNotifications() {
    return _preferences.getInt("unreadNotifications") ?? 0;
  }
  static String getCountryIdcountryId() {
    return _preferences.getString("country_idcountry_id") ?? "";
  }

  static setCountryIdcountryId(String countryIdcountryId) async {
    await _preferences.setString("country_idcountry_id", countryIdcountryId);
  }
  static String getUserType() {
    return _preferences.getString("userType") ?? "";
  }

  static setUserType(String userType) async {
    await _preferences.setString("userType", userType);
  }
  static setFCMToken(String token) async {
    await _preferences.setString("fcm_token", token);
  }

  static String getFCMToken() {
    return _preferences.getString("fcm_token") ?? "";
  }
  static setUserToken(String token) async {
    await _preferences.setString("token", token);
  }
  static String getUserToken() {
    return _preferences.getString("token") ?? "";
  }

  static setCountryId(String countryId) async {
    await _preferences.setString("country_id", countryId);
  }

  static String getCountryId() {
    return _preferences.getString("country_id") ?? "";
  }static setlLang(String token) async {
    await _preferences.setString("lang", token);
  }
  static String getCountryName() {
    return _preferences.getString("country_name") ?? "";
  }

  static setCountryNationality(String nationality) async {
    await _preferences.setString("nationality", nationality);
  }

  static String getCountryNationality() {
    return _preferences.getString("nationality") ?? "";
  }

  static setCountryKey(String countryKey) async {
    await _preferences.setString("country_key", countryKey);
  }

  static String getCountryKey() {
    return _preferences.getString("country_key") ?? "";
  }

  static setCountryFlag(String countryFlag) async {
    await _preferences.setString("country_flag", countryFlag);
  }

  static String getCountryFlag() {
    return _preferences.getString("country_flag") ?? "";
  }

  static setCityName(String cityName) async {
    await _preferences.setString("city_name", cityName);
  }

  static String getCityName() {
    return _preferences.getString("city_name") ?? "";
  }

  static setCityId(String cityId) async {
    await _preferences.setString("city_id", cityId);
  }

  static String getCityId() {
    return _preferences.getString("city_id") ?? "";
  }

  static setUserCartCount(int userCartCount) async {
    await _preferences.setInt("userCartCount", userCartCount);
  }

  static int getUserCartCount() {
    return _preferences.getInt("userCartCount") ?? 0;
  }


  static String getLang() {
    return _preferences.getString("lang") ?? "";
  }

  static Future setIfIsVisitor(bool isVisitor) async {
    await _preferences.setBool("isVisitor", isVisitor);
  }

  static bool getIfIsVisitor() {
    return _preferences.getBool("isVisitor") ?? true;
  }


}