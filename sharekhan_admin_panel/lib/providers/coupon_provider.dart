import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/coupon_model.dart';

class CouponProvider extends ChangeNotifier {
  List<CouponModel> _coupons = [];
  List<CouponModel> get coupons => _coupons;

  Future<void> fetchCoupons() async {
    final querySnapshot = await couponsRef.get();
    _coupons = querySnapshot.docs
        .map((doc) => CouponModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addCoupon(CouponModel coupon) async {
    await couponsRef.doc(coupon.id).set(coupon.toMap());
    _coupons.add(coupon);
    notifyListeners();
  }

  Future<void> updateCoupon(CouponModel coupon) async {
    await couponsRef.doc(coupon.id).update(coupon.toMap());
    _coupons.removeWhere((element) => element.id == coupon.id);
    _coupons.add(coupon);
    notifyListeners();
  }

  Future<void> deleteCoupon(CouponModel coupon) async {
    await couponsRef.doc(coupon.id).delete();
    _coupons.removeWhere((element) => element.id == coupon.id);
    notifyListeners();
  }

  Future<void> toggleActive(CouponModel coupon, bool isActive) async {
    try {
      int index = _coupons.indexWhere((element) => element.id == coupon.id);
      _coupons[index] = coupon.copyWith(isActive: isActive);
      notifyListeners();
      await couponsRef.doc(coupon.id).update({'isActive': isActive});
    } catch (e) {
      int index = _coupons.indexWhere((element) => element.id == coupon.id);
      _coupons[index] = coupon.copyWith(isActive: !isActive);
      notifyListeners();
    }
  }
}
