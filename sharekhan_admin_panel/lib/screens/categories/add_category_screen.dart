import 'dart:typed_data';
import 'package:sharekhan_admin_panel/globals.dart';
import 'package:sharekhan_admin_panel/models/category_model.dart';
import 'package:sharekhan_admin_panel/navigation/go_router.dart';
import 'package:sharekhan_admin_panel/navigation/routes.dart';
import 'package:sharekhan_admin_panel/providers/category_provider.dart';
import 'package:sharekhan_admin_panel/widgets/common/add_tab_footer.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_loading.dart';
import 'package:sharekhan_admin_panel/widgets/common/secondary_tab_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:sharekhan_admin_panel/theme/app_theme.dart';
import 'package:sharekhan_admin_panel/utils/get_uuid.dart';
import 'package:sharekhan_admin_panel/widgets/common/custom_button.dart';
import 'package:sharekhan_admin_panel/widgets/common/spacing.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String _fileName = 'File Name';
  Uint8List? _imageData;
  String? _imageUrl;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final MediaInfo? pickedFile = await ImagePickerWeb.getImageInfo();
    if (pickedFile != null) {
      setState(() {
        _imageData = pickedFile.data;
        _fileName = pickedFile.fileName!;
      });
    }
  }

  Future<String> _uploadImage(Uint8List imageData, String categoryID) async {
    final storageRef = firebaseStorage.ref();
    final imagesRef = storageRef.child('categories/$categoryID.png');
    await imagesRef.putData(imageData);
    final imageUrl = await imagesRef.getDownloadURL();
    return imageUrl;
  }

  _addCategory() async {
    setState(() {
      _isLoading = true;
    });
    final categoryProvider = context.read<CategoryProvider>();
    String categoryID = getUUID();
    if (_imageData != null) {
      _imageUrl = await _uploadImage(_imageData!, categoryID);
    }

    CategoryModel category = CategoryModel(
        id: categoryID,
        description: _descriptionController.text,
        name: _nameController.text,
        imageUrl: _imageUrl!,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now());
    await categoryProvider.addCategory(category);
    setState(() {
      _isLoading = false;
    });
    router.go(Routes.categories);
  }

  void _onReset() {
    setState(() {
      _fileName = 'File Name';
      _imageData = null;
      _imageUrl = null;
      _descriptionController.clear();
      _nameController.clear();
    });
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
                          goBackRoute: Routes.categories,
                          mainTitle: 'Categories',
                          secondaryTitle: 'Add Category'),
                      const Spacing(size: AppTheme.spacingSmall),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Image*',
                                style: AppTheme.fontStyleDefault
                                    .copyWith(color: AppTheme.colorGrey),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 200,
                                    padding: AppTheme.paddingTiny,
                                    decoration: AppTheme.cardDecoration,
                                    child: Text(
                                      _fileName,
                                      style: AppTheme.fontStyleSmall
                                          .copyWith(color: AppTheme.colorGrey),
                                    ),
                                  ),
                                  const Spacing(
                                      size: AppTheme.spacingTiny,
                                      isHorizontal: true),
                                  CustomButton(
                                    onTap: _pickImage,
                                    text: 'Upload Image',
                                    fillColor: AppTheme.colorRed,
                                    textColor: AppTheme.colorWhite,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacing(
                              size: AppTheme.spacingMedium, isHorizontal: true),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name*',
                                style: AppTheme.fontStyleDefault
                                    .copyWith(color: AppTheme.colorGrey),
                              ),
                              const Spacing(size: AppTheme.spacingTiny),
                              SizedBox(
                                width: 600,
                                child: TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter the Category description here',
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
                              hintText: 'Enter the Category description here',
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
                  AddTabFooter(
                    goBackrouteName: Routes.categories,
                    onAdd: _addCategory,
                    onReset: _onReset,
                    buttonText: 'Add Category',
                  ),
                ],
              ),
            ),
          )
        : const CustomLoading();
  }
}
