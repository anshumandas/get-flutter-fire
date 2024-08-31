import 'package:flutter/material.dart';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/banner_model.dart';

class BannerProvider extends ChangeNotifier {
  List<BannerModel> _banners = [];
  List<BannerModel> get banners => _banners;

  Future<void> fetchBanners() async {
    final querySnapshot = await bannersRef.get();
    _banners = querySnapshot.docs
        .map((doc) => BannerModel.fromMap(doc.data()))
        .toList();
    notifyListeners();
  }

  Future<void> addBanner(BannerModel banner) async {
    await bannersRef.doc(banner.id).set(banner.toMap());
    _banners.add(banner);
    notifyListeners();
  }

  Future<void> updateBanner(BannerModel banner) async {
    await bannersRef.doc(banner.id).update(banner.toMap());
    _banners.removeWhere((element) => element.id == banner.id);
    _banners.add(banner);
    notifyListeners();
  }

  Future<void> deleteBanner(BannerModel banner) async {
    await bannersRef.doc(banner.id).delete();
    _banners.removeWhere((element) => element.id == banner.id);
    notifyListeners();
  }

  Future<void> toggleActive(BannerModel banner, bool isActive) async {
    try {
      int index = _banners.indexWhere((element) => element.id == banner.id);
      _banners[index] = banner.copyWith(isActive: isActive);
      notifyListeners();
      await bannersRef.doc(banner.id).update({'isActive': isActive});
    } catch (e) {
      int index = _banners.indexWhere((element) => element.id == banner.id);
      _banners[index] = banner.copyWith(isActive: !isActive);
      notifyListeners();
    }
  }
}
