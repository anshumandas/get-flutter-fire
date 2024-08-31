import 'package:flutter/material.dart';
// import 'package:get/get_utils/src/platform/platform.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

const useEmulator = false;

const useRecaptcha = false;

const sendMailFromClient =
    true; // set this true if in server using custom claim status

const emulatorHost =
    "127.0.0.1"; // GetPlatform.isAndroid ? "10.0.2.2" : "127.0.0.1"; //This is not required due to automaticHostMapping

const baseUrl = useEmulator ? "http://127.0.0.1" : "your domain";

const bundleID = "com.example.getFlutterFireMain";
