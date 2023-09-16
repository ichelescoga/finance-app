import "package:developer_company/widgets/app_bar_title.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";

class MarketingAlbumDetailMaintenance extends StatefulWidget {
  const MarketingAlbumDetailMaintenance({Key? key}) : super(key: key);

  @override
  _MarketingAlbumDetailMaintenanceState createState() =>
      _MarketingAlbumDetailMaintenanceState();
}

class _MarketingAlbumDetailMaintenanceState
    extends State<MarketingAlbumDetailMaintenance> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: [],
        appBar: CustomAppBarTitle(title: "Albums"),
        child: Text("hello"));
  }
}
