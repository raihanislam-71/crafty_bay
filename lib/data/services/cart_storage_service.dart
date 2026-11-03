import 'package:shared_preferences/shared_preferences.dart';

class CartStorageService {
  static const String _keyPrefix = 'cart_qty_';

  static Future<void> saveQuantity(int itemId, int quantity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_keyPrefix$itemId', quantity);
  }

  static Future<Map<int, int>> loadQuantities() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<int, int> quantities = {};
    for (String key in prefs.getKeys()) {
      if (key.startsWith(_keyPrefix)) {
        final int? itemId = int.tryParse(key.replaceFirst(_keyPrefix, ''));
        final int? qty = prefs.getInt(key);
        if (itemId != null && qty != null) {
          quantities[itemId] = qty;
        }
      }
    }
    return quantities;
  }

  static Future<void> removeQuantity(int itemId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_keyPrefix$itemId');
  }
}
