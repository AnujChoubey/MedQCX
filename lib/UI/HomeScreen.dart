import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../API/getDevices.dart';
import '../globals/globalVariables.dart';
import '../globals/commonComponents.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfff5fbff),
      appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/medLogo.jpg',
                height: 40,
                width: 40,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'My Devices',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.white),
      // bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: )],),
      body: _body(),
    );
  }

  var workingList = [];

  var inServiceList = [];

  var standByList = [];

  _body() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FutureBuilder<List<Device>>(
          future: fetchDevices(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final devices = snapshot.data!;

              workingList = [];

              inServiceList = [];

              standByList = [];
// code to filter the data
              for (int i = 0; i < devices.length; i++) {
                if (devices[i].status == 'working') {
                  workingList.add(devices[i]);
                } else if (devices[i].status == 'in-service') {
                  inServiceList.add(devices[i]);
                } else {
                  standByList.add(devices[i]);
                }
              }
              // Display the list of devices
              return RefreshIndicator(
                onRefresh: fetchDevices,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            // Text('Sort by - Status'),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    stat = 0;
                                  });
                                },
                                child: Chip(
                                    backgroundColor:
                                        Colors.purple.withOpacity(0.1),
                                    label: Text(
                                      'Working',
                                      style: TextStyle(fontSize: 12),
                                    ))),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    stat = 1;
                                  });
                                },
                                child: Chip(
                                    backgroundColor:
                                        Colors.purple.withOpacity(0.1),
                                    label: Text(
                                      'Stand-by',
                                      style: TextStyle(fontSize: 12),
                                    ))),
                            SizedBox(
                              width: 10,
                            ),

                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    stat = 2;
                                  });
                                },
                                child: Chip(
                                    backgroundColor:
                                        Colors.purple.withOpacity(0.1),
                                    label: Text(
                                      'In-service',
                                      style: TextStyle(fontSize: 12),
                                    ))),
                            SizedBox(
                              width: 10,
                            ),

                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    stat = 3;
                                  });
                                },
                                child: Chip(
                                    backgroundColor:
                                        Colors.purple.withOpacity(0.1),
                                    label: Text(
                                      'Reset',
                                      style: TextStyle(fontSize: 12),
                                    ))),
                          ],
                        ),
                      ),
                      stat == 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: workingList.length,
                              itemBuilder: (context, index) {
                                final device = workingList[index];
                                return CommonComponents(
                                  deviceModel: device.deviceModel,
                                  health: device.health,
                                  imageUrl: device.imageUrl,
                                  manufacturer: device.manufacturer,
                                  name: device.name,
                                  serialNumber: device.serialNumber,
                                  status: device.status,
                                );
                              },
                            )
                          : stat == 1
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: standByList.length,
                                  itemBuilder: (context, index) {
                                    final device = standByList[index];
                                    return CommonComponents(
                                      deviceModel: device.deviceModel,
                                      health: device.health,
                                      imageUrl: device.imageUrl,
                                      manufacturer: device.manufacturer,
                                      name: device.name,
                                      serialNumber: device.serialNumber,
                                      status: device.status,
                                    );
                                  },
                                )
                              : stat == 2
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: inServiceList.length,
                                      itemBuilder: (context, index) {
                                        final device = inServiceList[index];
                                        return CommonComponents(
                                          deviceModel: device.deviceModel,
                                          health: device.health,
                                          imageUrl: device.imageUrl,
                                          manufacturer: device.manufacturer,
                                          name: device.name,
                                          serialNumber: device.serialNumber,
                                          status: device.status,
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: devices.length,
                                      itemBuilder: (context, index) {
                                        final device = devices[index];
                                        return CommonComponents(
                                          deviceModel: device.deviceModel,
                                          health: device.health,
                                          imageUrl: device.imageUrl,
                                          manufacturer: device.manufacturer,
                                          name: device.name,
                                          serialNumber: device.serialNumber,
                                          status: device.status,
                                        );
                                      },
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
          },
        ));
  }
}
