import 'package:sharekhan_admin_panel/models/coupon_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/coupon_provider.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_loading.dart';
import 'package:sharekhan_admin_panel/widgets/common/edit_tab_footer.dart';
import 'package:sharekhan_admin_panel/widgets/common/secondary_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';

class EditCouponScreen extends StatefulWidget {
  final CouponModel coupon;
  const EditCouponScreen({super.key, required this.coupon});

  @override
  State<EditCouponScreen> createState() => _EditCouponScreenState();
}

class _EditCouponScreenState extends State<EditCouponScreen> {
  final TextEditingController _couponCodeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _maxAmountController = TextEditingController();
  bool _isLoading = false;

  _editCoupon() async {
    setState(() {
      _isLoading = true;
    });
    final couponProvider = context.read<CouponProvider>();

    CouponModel coupon = CouponModel(
      id: widget.coupon.id,
      couponCode: _couponCodeController.text.toUpperCase(),
      description: _descriptionController.text,
      percentage: double.parse(_percentageController.text),
      maxAmount: int.parse(_maxAmountController.text),
      userIDs: [],
      isActive: true,
      createdAt: widget.coupon.createdAt,
      updatedAt: DateTime.now(),
    );

    await couponProvider.updateCoupon(coupon);
    setState(() {
      _isLoading = false;
    });
    router.go(Routes.coupons);
  }

  @override
  void initState() {
    _couponCodeController.text = widget.coupon.couponCode;
    _descriptionController.text = widget.coupon.description;
    _percentageController.text = widget.coupon.percentage.toString();
    _maxAmountController.text = widget.coupon.maxAmount.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? Scaffold(
            backgroundColor: AppTheme.colorWhite,
            body: Padding(
              padding: AppTheme.paddingSmall,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Spacing(size: AppTheme.spacingLarge),
                      const BreadcrumbTabHeader(
                        goBackRoute: Routes.coupons,
                        mainTitle: 'Coupons',
                        secondaryTitle: 'Edit Coupons',
                      ),
                      const Spacing(size: AppTheme.spacingSmall),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Coupon Code*',
                                style: AppTheme.fontStyleDefault
                                    .copyWith(color: AppTheme.colorGrey),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              SizedBox(
                                width: 300,
                                child: TextField(
                                  controller: _couponCodeController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter the Coupon code here',
                                    hintStyle:
                                        AppTheme.fontStyleDefault.copyWith(
                                      color: AppTheme.greyTextColor,
                                    ),
                                    border: AppTheme.textfieldBorder,
                                    enabledBorder: AppTheme.textfieldBorder,
                                    focusedBorder: AppTheme.textfieldBorder,
                                    filled: true,
                                    fillColor: AppTheme.colorWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacing(
                              size: AppTheme.spacingMedium, isHorizontal: true),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Percentage*',
                                style: AppTheme.fontStyleDefault
                                    .copyWith(color: AppTheme.colorGrey),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: _percentageController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter percentage',
                                    hintStyle:
                                        AppTheme.fontStyleDefault.copyWith(
                                      color: AppTheme.greyTextColor,
                                    ),
                                    border: AppTheme.textfieldBorder,
                                    enabledBorder: AppTheme.textfieldBorder,
                                    focusedBorder: AppTheme.textfieldBorder,
                                    filled: true,
                                    fillColor: AppTheme.colorWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacing(
                              size: AppTheme.spacingMedium, isHorizontal: true),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Max Amount*',
                                style: AppTheme.fontStyleDefault
                                    .copyWith(color: AppTheme.colorGrey),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: _maxAmountController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter max amount',
                                    hintStyle:
                                        AppTheme.fontStyleDefault.copyWith(
                                      color: AppTheme.greyTextColor,
                                    ),
                                    border: AppTheme.textfieldBorder,
                                    enabledBorder: AppTheme.textfieldBorder,
                                    focusedBorder: AppTheme.textfieldBorder,
                                    filled: true,
                                    fillColor: AppTheme.colorWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacing(size: AppTheme.spacingMedium),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description*',
                            style: AppTheme.fontStyleDefault
                                .copyWith(color: AppTheme.colorGrey),
                          ),
                          const Spacing(size: AppTheme.spacingTiny),
                          TextField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Enter the Coupon description here',
                              hintStyle: AppTheme.fontStyleDefault.copyWith(
                                color: AppTheme.greyTextColor,
                              ),
                              border: AppTheme.textfieldBorder,
                              enabledBorder: AppTheme.textfieldBorder,
                              focusedBorder: AppTheme.textfieldBorder,
                              filled: true,
                              fillColor: AppTheme.colorWhite,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  EditTabFooter(
                    goBackrouteName: Routes.coupons,
                    onSave: _editCoupon,
                  ),
                ],
              ),
            ),
          )
        : const CustomLoading();
  }
}
