// lib/src/services/permission_service.dart
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';


class PermissionService {
  Future<bool> requestPermissions() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    bool permissionStatus;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.audio.request().isGranted;
    } else {
      permissionStatus = await Permission.audio.request().isGranted;
    }

    return permissionStatus;
  }

  Future<bool> hasPermissions() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    bool permissionStatus;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.audio.status.isGranted ;
    } else {
      permissionStatus = await Permission.audio.status.isGranted ;
    }

    return permissionStatus;
  }
}