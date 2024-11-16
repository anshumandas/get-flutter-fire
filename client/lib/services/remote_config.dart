import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get_utils/src/platform/platform.dart';

enum Typer { integer, boolean, double, string }

class RemoteConfig {
  static RemoteConfig? _instance;

  static Future<RemoteConfig> get instance async {
    _instance = _instance ?? RemoteConfig();
    await _instance!.init();
    return _instance!;
  }

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final List listeners = [];

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: //const Duration(hours: 1), //use for prod
          const Duration(minutes: 5), //use for testing only
    ));

    await _remoteConfig.setDefaults(const {
      "useBottomSheetForProfileOptions": false,
      "showSearchBarOnTop": true,
    });

    await fetch();
  }

  Future<bool> fetch() async {
    return await _remoteConfig.fetchAndActivate();
  }

//can be used to change config without restart
  void addListener(String key, Typer typ, Function listener) async {
    if (!GetPlatform.isWeb) {
      _remoteConfig.onConfigUpdated. //not supported in web
          listen((event) async {
        await _remoteConfig.activate();
        if (event.updatedKeys.contains(key)) {
          _remoteConfig.fetch();
          var val = _remoteConfig.getValue(key);
          switch (typ) {
            case Typer.integer:
              listener(val.asInt());
              break;
            case Typer.boolean:
              listener(val.asInt());
              break;
            case Typer.double:
              listener(val.asDouble());
              break;
            default:
              listener(val.asString());
          }
        }
      });
    }
  }

  bool useBottomSheetForProfileOptions() {
    return _remoteConfig.getBool("useBottomSheetForProfileOptions");
  }

  bool showSearchBarOnTop() {
    return _remoteConfig.getBool("showSearchBarOnTop");
  }

  void addUseBottomSheetForProfileOptionsListener(listener) {
    addListener("useBottomSheetForProfileOptions", Typer.boolean, listener);
    if (!listeners.contains(listener)) {
      listeners.add(listener);
    }
  }
}
