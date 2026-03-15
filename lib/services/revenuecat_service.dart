import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

class RevenueCatService {
  RevenueCatService._();
  static final instance = RevenueCatService._();

  static const String _apiKey = 'test_gFKSXHoAKWePtGQLzGdLTNHVJRf';
  static const String entitlementId = 'Mantra Pro';

  bool _initialized = false;
  CustomerInfo? _customerInfo;

  /// Whether the user has an active "Mantra Pro" entitlement.
  bool get isPro {
    final entitlement = _customerInfo?.entitlements.all[entitlementId];
    return entitlement?.isActive ?? false;
  }

  /// Current customer info (cached).
  CustomerInfo? get customerInfo => _customerInfo;

  /// Initialize RevenueCat SDK — call once at app start.
  Future<void> init() async {
    if (_initialized) return;

    await Purchases.setLogLevel(LogLevel.debug);

    // All platforms use the same key in this project.
    final configuration = PurchasesConfiguration(_apiKey);
    await Purchases.configure(configuration);
    _initialized = true;

    // Fetch initial customer info.
    try {
      _customerInfo = await Purchases.getCustomerInfo();
    } catch (e) {
      debugPrint('RevenueCat: Failed to get customer info: $e');
    }

    // Listen for updates via the listener API (v9 does not expose a stream).
    Purchases.addCustomerInfoUpdateListener((info) {
      _customerInfo = info;
    });
  }

  /// Login a user (call after authentication).
  Future<void> login(String userId) async {
    try {
      final result = await Purchases.logIn(userId);
      _customerInfo = result.customerInfo;
    } catch (e) {
      debugPrint('RevenueCat: Login failed: $e');
    }
  }

  /// Logout (returns to anonymous user).
  Future<void> logout() async {
    try {
      _customerInfo = await Purchases.logOut();
    } catch (e) {
      debugPrint('RevenueCat: Logout failed: $e');
    }
  }

  /// Get available offerings (products from RevenueCat dashboard).
  Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('RevenueCat: Failed to get offerings: $e');
      return null;
    }
  }

  /// Purchase a specific package using the current API.
  Future<bool> purchasePackage(Package package) async {
    try {
      final result = await Purchases.purchase(
        PurchaseParams.package(package),
      );
      _customerInfo = result.customerInfo;
      return isPro;
    } on PurchasesErrorCode catch (e) {
      if (e == PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('RevenueCat: Purchase cancelled by user');
      } else {
        debugPrint('RevenueCat: Purchase error: $e');
      }
      return false;
    } catch (e) {
      debugPrint('RevenueCat: Purchase error: $e');
      return false;
    }
  }

  /// Restore previous purchases.
  Future<bool> restorePurchases() async {
    try {
      _customerInfo = await Purchases.restorePurchases();
      return isPro;
    } catch (e) {
      debugPrint('RevenueCat: Restore failed: $e');
      return false;
    }
  }

  /// Check if user has active Pro entitlement (fresh from server).
  Future<bool> checkProStatus() async {
    try {
      _customerInfo = await Purchases.getCustomerInfo();
      return isPro;
    } catch (e) {
      debugPrint('RevenueCat: Status check failed: $e');
      return false;
    }
  }

  /// Present the RevenueCat native paywall.
  Future<PaywallResult> presentPaywall() async {
    return RevenueCatUI.presentPaywall();
  }

  /// Present paywall only if the user lacks the Pro entitlement.
  /// [requiredEntitlementIdentifier] is a positional parameter in v9.
  Future<PaywallResult> presentPaywallIfNeeded() async {
    return RevenueCatUI.presentPaywallIfNeeded(entitlementId);
  }
}
