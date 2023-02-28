import 'dart:convert';
import 'package:http/http.dart' as http;

class DeviceInfo {
  final int? createdById;
  final String deviceModel;
  final List<String>? imageUrls;
  final String insertedAt;
  final String lastServiceDate;
  final int maintenanceCycle;
  final String manufacturer;
  final String name;
  final String serialNumber;
  final String updatedAt;
  final int? updatedById;
  final String warrantyTill;
  final String warrantyType;
  final List<ServiceHistory> serviceHistory;

  DeviceInfo({
    this.createdById,
    required this.deviceModel,
    this.imageUrls,
    required this.insertedAt,
    required this.lastServiceDate,
    required this.maintenanceCycle,
    required this.manufacturer,
    required this.name,
    required this.serialNumber,
    required this.updatedAt,
    this.updatedById,
    required this.warrantyTill,
    required this.warrantyType,
    required this.serviceHistory,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) {
    final serviceHistoryList = json['service_history'] as List;
    final serviceHistory =
        serviceHistoryList.map((sh) => ServiceHistory.fromJson(sh)).toList();
    return DeviceInfo(
      createdById: json['created_by_id'],
      deviceModel: json['device_model'],
      imageUrls: json['image_urls'] != null
          ? List<String>.from(json['image_urls'])
          : null,
      insertedAt: json['inserted_at'],
      lastServiceDate: json['last_service_date'],
      maintenanceCycle: json['maintenance_cycle'],
      manufacturer: json['manufacturer'],
      name: json['name'],
      serialNumber: json['serial_number'],
      updatedAt: json['updated_at'],
      updatedById: json['updated_by_id'],
      warrantyTill: json['warranty_till'],
      warrantyType: json['warranty_type'],
      serviceHistory: serviceHistory,
    );
  }
}

class ServiceHistory {
  final int id;
  final String serviceType;

  ServiceHistory({required this.id, required this.serviceType});

  factory ServiceHistory.fromJson(Map<String, dynamic> json) {
    return ServiceHistory(
      id: json['id'],
      serviceType: json['service_type'],
    );
  }
}

Future<DeviceInfo> fetchMoreData() async {
  final response =
      await http.get(Uri.parse('https://jsonblob.com/api/1079330676414889984'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return DeviceInfo.fromJson(data);
    // print('error');

  } else {
    throw Exception('Failed to fetch more info');
  }
}
