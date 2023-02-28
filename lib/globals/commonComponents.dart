import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI/moreInfo.dart';
import 'globalVariables.dart';

class CommonComponents extends StatelessWidget {
  CommonComponents(
      {Key? key,
      this.imageUrl,
      this.name,
      this.manufacturer,
      this.health,
      this.status,
      this.deviceModel,
      this.serialNumber})
      : super(key: key);
  String? deviceModel;
  String? id;
  String? manufacturer;
  String? name;
  String? serialNumber;
  int? health;
  String? status;
  String? imageUrl;

  @override
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
//function to capitalize the first letter of a string.
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 100, width: 100, child: Image.network(imageUrl!)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(capitalize(name!)),
                    Text(capitalize(manufacturer!)),
                    Row(
                      children: [
                        Text(
                          'Model:',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(deviceModel![1])
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Serial No:',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(serialNumber!)
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        heartWidget(),
                        Text('${int.parse((health! / 2).toStringAsFixed(0))}/3')
                      ],
                    ),
                    Container(
                      height: 35,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            isInfo == false
                ? Row(
                    children: [
                      Expanded(
                        child: commonButtonFilled('Raise Complaint'),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreInfo(
                                      serialNumber: serialNumber,
                                      name: name,
                                      manufacturer: manufacturer,
                                      imageUrl: imageUrl,
                                      health: health,
                                      deviceModel: deviceModel,
                                      status: status,
                                    )),
                          );
                        },
                        child: commonButtonWhite(),
                      ))
                    ],
                  )
                : Container()
          ],
        ));
  }

  heartWidget() {
    switch (int.parse((health! / 2).toStringAsFixed(0))) {
      case 0:
        return SizedBox(
            width: 80,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.red.shade900,
                ),
              ],
            ));
      case 1:
        return SizedBox(
            width: 80,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.red.shade900,
                ),
              ],
            ));
      // return Icon(CupertinoIcons.heart);
      case 2:
        return SizedBox(
            width: 80,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart,
                  color: Colors.red.shade900,
                ),
              ],
            ));
      case 3:
        return SizedBox(
            width: 80,
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red.shade900,
                ),
                Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red.shade900,
                ),
              ],
            ));
    }
    return Row(
      children: [
        SizedBox(
          width: 80,
          height: 40,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (ctx, index) {
                return Icon(CupertinoIcons.heart_fill);
              }),
        )
      ],
    );
  }
}
