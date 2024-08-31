import 'dart:convert';

class SettingsModel {
  final AppVersion version;
  SettingsModel({
    required this.version,
  });

  SettingsModel copyWith({
    AppVersion? version,
  }) {
    return SettingsModel(
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version.toMap(),
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      version: AppVersion.fromMap(map['version'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsModel.fromJson(String source) =>
      SettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SettingsModel(version: $version)';
}

class AppVersion {
  final Version androidVersion;
  final Version iosVersion;
  final bool isMaintenance;
  AppVersion({
    required this.androidVersion,
    required this.iosVersion,
    required this.isMaintenance,
  });

  AppVersion copyWith({
    Version? androidVersion,
    Version? iosVersion,
    bool? isMaintenance,
  }) {
    return AppVersion(
      androidVersion: androidVersion ?? this.androidVersion,
      iosVersion: iosVersion ?? this.iosVersion,
      isMaintenance: isMaintenance ?? this.isMaintenance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'androidVersion': androidVersion.toMap(),
      'iosVersion': iosVersion.toMap(),
      'isMaintenance': isMaintenance,
    };
  }

  factory AppVersion.fromMap(Map<String, dynamic> map) {
    return AppVersion(
      androidVersion:
          Version.fromMap(map['androidVersion'] as Map<String, dynamic>),
      iosVersion: Version.fromMap(map['iosVersion'] as Map<String, dynamic>),
      isMaintenance: map['isMaintenance'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppVersion.fromJson(String source) =>
      AppVersion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AppVersion(androidVersion: $androidVersion, iosVersion: $iosVersion, isMaintenance: $isMaintenance)';
}

class Version {
  final String versionName;
  final bool mandatory;
  Version({
    required this.versionName,
    required this.mandatory,
  });

  Version copyWith({
    String? versionName,
    bool? mandatory,
  }) {
    return Version(
      versionName: versionName ?? this.versionName,
      mandatory: mandatory ?? this.mandatory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'versionName': versionName,
      'mandatory': mandatory,
    };
  }

  factory Version.fromMap(Map<String, dynamic> map) {
    return Version(
      versionName: map['versionName'] as String,
      mandatory: map['mandatory'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Version.fromJson(String source) =>
      Version.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Version(versionName: $versionName, mandatory: $mandatory)';
}
