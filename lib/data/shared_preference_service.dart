import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/wallet_model/wallet_model.dart';

class SharedPreferencesService {
  static const String key = 'wallet_data';

  // Сохранение списка LoanOutputData в SharedPreferences
  static Future<bool> saveLoanOutputDataList(WalletModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(data.toJson()); // Convert the WalletModel to a JSON string
    return prefs.setString(key, jsonData);
  }

  // Получение списка LoanOutputData из SharedPreferences
  static Future<WalletModel?> getLoanOutputDataList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString(key);
    if (jsonData != null) {
      // Convert the JSON string back to a Map
      Map<String, dynamic> dataMap = json.decode(jsonData);
      // Create a WalletModel from the Map
      return WalletModel.fromJson(dataMap);
    } else {
      return null;
    }
  }

  static Future<void> addLoanOutput(WalletModel walletChanges) async {
    await saveLoanOutputDataList(walletChanges);
  }
}