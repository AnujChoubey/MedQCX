// import 'package:flutter/cupertino.dart';
// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
// import 'package:globals/commonComponents.dart';
import 'dart:io';
import '../API/moreInfo.dart';
import '../globals/commonComponents.dart';
import '../globals/globalVariables.dart';

class MoreInfo extends StatefulWidget {
  MoreInfo(
      {Key? key,
      this.imageUrl,
      this.name,
      this.manufacturer,
      this.health,
      this.status,
      this.deviceModel,
      this.serialNumber,
      // this.createdById,
      // this.deviceModelInfo,
      // this.imageUrls,
      this.maintenanceCycle,
      this.lastServiceDate,
      this.serviceHistory,
      this.warrantyType})
      : super(key: key);
  String? deviceModel;
  String? manufacturer;
  String? name;
  String? serialNumber;
  int? health;
  String? status;
  String? imageUrl;
  String? lastServiceDate;
  int? maintenanceCycle;
  String? warrantyType;
  List<ServiceHistory>? serviceHistory;

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  String? id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isInfo = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        isInfo = false;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          titleSpacing: -10,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Device Details',
            style: TextStyle(color: Colors.black),
          ),
          leading: InkWell(
              onTap: () {
                isInfo = false;
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 18,
              )),
        ),
        body: _body(),
      ),
    );
  }

  // var dateFormatted = DateFormat("yyyy-MM-ddTHH:mm:ss").format(now);
  _body() {
    return FutureBuilder(
        future: fetchMoreData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final deviceData = snapshot.data;
            // var formattedDate = formatDate(deviceData.);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'DEVICE INFO',
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 16),
                    ),
                    CommonComponents(
                      deviceModel: widget.deviceModel,
                      health: widget.health,
                      imageUrl: widget.imageUrl,
                      manufacturer: widget.manufacturer,
                      name: widget.name,
                      serialNumber: widget.serialNumber,
                      status: widget.status,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'CONTRACTS AND CERTIFICATIONS',
                          style: TextStyle(
                              color: Colors.blue.shade700, fontSize: 16),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.blue.shade700,
                          size: 17,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    rowItem('Warranty', 'Yes'),
                    rowItem('Insurance', 'Yes'),
                    rowItem('Additional Certificates', 'No'),
                    rowItem('AMC/CMC', deviceData!.warrantyType),
                    rowItem('Last Service Date', deviceData.lastServiceDate),
                    rowItem('Maintenance Cycle',
                        deviceData.maintenanceCycle.toString()),
                    rowItem('Next Service Date', ''),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'SERVICE HISTORY',
                      style:
                          TextStyle(color: Colors.blue.shade700, fontSize: 16),
                    ),
                    rowItemButton('01 Jan 2021'),
                    rowItemButton('31 Dec 2021'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.purple.shade900,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Troubleshoot',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Display an error message
            return Text('${snapshot.error}');
          } else {
            // Display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  rowItem(String title, String val) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: SizedBox(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              val,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  rowItemButton(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: SizedBox(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            commonButtonFilled('View Report')
          ],
        ),
      ),
    );
  }
}
