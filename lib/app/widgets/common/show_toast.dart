import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_flutter_fire/theme/app_theme.dart';

void showToast(message, {bool isError = false, bool isShort = false}) {
//TODO: implement showToast correctly
  Fluttertoast.showToast(
      msg: message,
      toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: isShort ? 1 : 5,
      backgroundColor: isError ? AppTheme.colorRed : AppTheme.colorRed,
      textColor: isError ? AppTheme.colorBlack : AppTheme.colorWhite,
      fontSize: AppTheme.fontSizeDefault);
}
