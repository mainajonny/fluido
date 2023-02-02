import 'package:flutter/material.dart';

import '../constants.dart';

defaultIconBottomSheet(BuildContext context, String title, Widget myWidget,
        IconData sheetIcon, EdgeInsetsGeometry padding) =>
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 80,
                color: Colors.transparent,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                color: Color(0xFFEEEEEE),
                              ),
                              child: const Icon(Icons.close_rounded)),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: kPrimaryColorLight,
                            child: Icon(
                              sheetIcon,
                              color: kPrimaryColor,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      myWidget,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
