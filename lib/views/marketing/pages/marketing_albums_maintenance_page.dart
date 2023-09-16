import "package:developer_company/widgets/app_bar_sidebar.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";

class MarketingAlbumsMaintenancePage extends StatefulWidget {
  const MarketingAlbumsMaintenancePage({Key? key}) : super(key: key);

  @override
  _MarketingAlbumsMaintenancePageState createState() =>
      _MarketingAlbumsMaintenancePageState();
}

class _MarketingAlbumsMaintenancePageState
    extends State<MarketingAlbumsMaintenancePage> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarSideBar(title: "Albums"),
        child: Text("hello"));
  }
}
