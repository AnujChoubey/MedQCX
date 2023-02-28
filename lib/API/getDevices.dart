import 'dart:convert';
import 'package:http/http.dart' as http;

class Device {
  final String deviceModel;
  final String id;
  final String manufacturer;
  final String name;
  final String serialNumber;
  final int health;
  final String status;
  final String imageUrl;

  Device({
    required this.deviceModel,
    required this.id,
    required this.manufacturer,
    required this.name,
    required this.serialNumber,
    required this.health,
    required this.status,
    required this.imageUrl,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      deviceModel: json['device_model'],
      id: json['id'],
      manufacturer: json['manufacturer'],
      name: json['name'],
      serialNumber: json['serial_number'],
      health: json['health'],
      status: json['status'],
      imageUrl: json['image_url'],
    );
  }
}

Future<List<Device>> fetchDevices() async {
  final response =
      await http.get(Uri.parse('https://jsonblob.com/api/1079326132867973120'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body)['list'];
    return jsonList.map((json) => Device.fromJson(json)).toList();
  } else {
    throw Exception('Failed to fetch devices');
  }
}
