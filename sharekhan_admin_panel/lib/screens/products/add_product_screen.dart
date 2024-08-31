import 'dart:typed_data';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/product_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/category_provider.dart';
import 'package:sharekhan_admin_panel/providers/product_provider.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_dropdown.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_loading.dart';
import 'package:sharekhan_admin_panel/widgets/common/add_tab_footer.dart';
import 'package:sharekhan_admin_panel/widgets/common/secondary_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/utils/get_uuid.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _unitWeightController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _remainingQuantityController =
      TextEditingController();

  List<String> _categories = [];
  final List<Uint8List?> _imageDataList = [];
  final List<String> _imageUrls = [];
  final List<String> _fileNames = [];
  String _categoryID = '';
  bool _isLoading = false;

  Future<void> _pickImage(int index) async {
    final MediaInfo? pickedFile = await ImagePickerWeb.getImageInfo();
    if (pickedFile != null) {
      setState(() {
        if (index < _imageDataList.length) {
          _imageDataList[index] = pickedFile.data;
          _fileNames[index] = pickedFile.fileName!;
        } else {
          _imageDataList.add(pickedFile.data);
          _fileNames.add(pickedFile.fileName!);
        }
      });
    }
  }

  Future<String> _uploadImage(
      Uint8List imageData, String productID, int index) async {
    final storageRef = firebaseStorage.ref();
    final imagesRef = storageRef.child('products/$productID-$index.png');
    await imagesRef.putData(imageData);
    final imageUrl = await imagesRef.getDownloadURL();
    return imageUrl;
  }

  _addProduct() async {
    setState(() {
      _isLoading = true;
    });

    final productProvider = context.read<ProductProvider>();
    String productID = getUUID();

    for (int i = 0; i < _imageDataList.length; i++) {
      if (_imageDataList[i] != null) {
        final imageUrl = await _uploadImage(_imageDataList[i]!, productID, i);
        _imageUrls.add(imageUrl);
      }
    }

    ProductModel product = ProductModel(
      id: productID,
      categoryID: _categoryID,
      images: _imageUrls,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      unitWeight: double.parse(_unitWeightController.text),
      unitPrice: int.parse(_unitPriceController.text),
      remainingQuantity: int.parse(_remainingQuantityController.text),
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      sellerId: 'admin',
      isSheruSpecial: true,
      isApproved: true,
    );

    await productProvider.addProduct(product);
    setState(() {
      _isLoading = false;
    });
    router.go(Routes.sheruProducts);
  }

  void _onReset() {
    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _unitWeightController.clear();
      _unitPriceController.clear();
      _categoryID = '';
      _imageDataList.clear();
      _imageUrls.clear();
      _fileNames.clear();
    });
  }

  init() async {
    final categoryProvider = context.read<CategoryProvider>();
    setState(() {
      _categories = categoryProvider.categories.map((e) => e.name).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    return !_isLoading
        ? Scaffold(
            backgroundColor: AppTheme.colorWhite,
            body: Padding(
              padding: AppTheme.paddingSmall,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Spacing(size: AppTheme.spacingLarge),
                        const BreadcrumbTabHeader(
                          goBackRoute: Routes.sheruProducts,
                          mainTitle: 'Products',
                          secondaryTitle: 'Add Products',
                        ),
                        const Spacing(size: AppTheme.spacingSmall),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Name*',
                                  style: AppTheme.fontStyleDefault
                                      .copyWith(color: AppTheme.colorGrey),
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter the Product name here',
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
                                size: AppTheme.spacingMedium,
                                isHorizontal: true),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Category ID*',
                                  style: AppTheme.fontStyleDefault
                                      .copyWith(color: AppTheme.colorGrey),
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                SizedBox(
                                  width: 300,
                                  child: CustomDropdown(
                                    hintText: 'Choose an option',
                                    value: _categoryID.isNotEmpty
                                        ? categoryProvider.categories
                                            .firstWhere((element) =>
                                                element.id == _categoryID)
                                            .name
                                        : null,
                                    items: _categories
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _categoryID = categoryProvider
                                            .categories
                                            .firstWhere((element) =>
                                                element.name == val)
                                            .id;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacing(size: AppTheme.spacingMedium),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unit Weight*',
                                  style: AppTheme.fontStyleDefault
                                      .copyWith(color: AppTheme.colorGrey),
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: _unitWeightController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter weight',
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
                                size: AppTheme.spacingMedium,
                                isHorizontal: true),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Unit Price*',
                                  style: AppTheme.fontStyleDefault
                                      .copyWith(color: AppTheme.colorGrey),
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: _unitPriceController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter price',
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
                                size: AppTheme.spacingMedium,
                                isHorizontal: true),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Remaining Quantity*',
                                  style: AppTheme.fontStyleDefault
                                      .copyWith(color: AppTheme.colorGrey),
                                ),
                                const Spacing(size: AppTheme.spacingTiny),
                                SizedBox(
                                  width: 200,
                                  child: TextField(
                                    controller: _remainingQuantityController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: 'Enter quantity',
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
                                hintText: 'Enter the Product description here',
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
                        const Spacing(size: AppTheme.spacingMedium),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < (_imageDataList.length + 1);
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Image ${i + 1}${i == 0 ? '*' : ''}',
                                          style: AppTheme.fontStyleDefault
                                              .copyWith(
                                                  color: AppTheme.colorGrey),
                                        ),
                                        const Spacing(
                                            size: AppTheme.spacingTiny),
                                        Container(
                                          height: 40,
                                          width: 300,
                                          padding: AppTheme.paddingTiny,
                                          decoration: AppTheme.cardDecoration,
                                          child: Text(
                                            i < _imageDataList.length
                                                ? _fileNames[i]
                                                : 'File Name',
                                            style: AppTheme.fontStyleSmall
                                                .copyWith(
                                                    color: AppTheme.colorGrey),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacing(
                                        size: AppTheme.spacingTiny,
                                        isHorizontal: true),
                                    CustomButton(
                                      onTap: () => _pickImage(i),
                                      text: 'Upload Image',
                                      fillColor: AppTheme.colorRed,
                                      textColor: AppTheme.colorWhite,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    AddTabFooter(
                      goBackrouteName: Routes.sheruProducts,
                      onAdd: _addProduct,
                      onReset: _onReset,
                      buttonText: 'Add Product',
                    ),
                  ],
                ),
              ),
            ),
          )
        : const CustomLoading();
  }
}
