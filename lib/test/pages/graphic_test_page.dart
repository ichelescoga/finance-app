import 'package:developer_company/shared/resources/colors.dart';

import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:developer_company/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GraphicTestPage extends StatefulWidget {
  const GraphicTestPage({Key? key}) : super(key: key);

  @override
  State<GraphicTestPage> createState() => _GraphicTestPageState();
}

class _GraphicTestPageState extends State<GraphicTestPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.BACKGROUND,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  size: 28, color: Colors.black54),
              onPressed: () {
                Get.back();
              },
            ),
            elevation: 0.25,
            backgroundColor: const Color(0xfff5f6fa),
            title: Text(
              Strings.signUp.toUpperCase(),
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(left: responsive.wp(5), right: responsive.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: responsive.hp(2)),

                  const SizedBox(height: Dimensions.heightSize)
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Get.back(closeOverlays: true);
          return false;
        });
  }
}
