import 'package:developer_company/data/implementations/discount_repository_impl.dart';
import 'package:developer_company/data/models/discount_model.dart';
import 'package:developer_company/data/providers/discount_provider.dart';
import 'package:developer_company/data/repositories/discount_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/views/discounts/screens/discounts_approved_screen.dart';
import 'package:developer_company/views/discounts/screens/discounts_by_resolution_screen.dart';
import 'package:developer_company/views/discounts/screens/discounts_rejected_screen.dart';
import 'package:developer_company/views/quotes/pages/quote_unit_status_page.dart';
import 'package:developer_company/widgets/app_bar_title.dart';
import 'package:developer_company/widgets/data_table.dart';
import 'package:developer_company/widgets/filter_box.dart';
import 'package:developer_company/widgets/layout.dart';
import 'package:developer_company/widgets/top_selector_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DiscountsByQuotePage extends StatefulWidget {
  const DiscountsByQuotePage({Key? key}) : super(key: key);

  @override
  _DiscountsByQuotePageState createState() => _DiscountsByQuotePageState();
}

class _DiscountsByQuotePageState extends State<DiscountsByQuotePage> {
  // final user = container.read(userProvider);
  // bool isLoading = false;

  // AppColors appColors = AppColors();

  // DiscountRepository discountRepository =
  //     DiscountRepositoryImpl(DiscountProvider());

  // List<RequestedDiscount> requestDiscounts = [];

  // fetchRequestedDiscounts() async {
  //   final projectId = user.project.projectId;
  //   try {
  //     setState(() => isLoading = true);
  //     EasyLoading.show();
  //     List<RequestedDiscount> listDiscounts =
  //         await discountRepository.getRequestDiscounts(projectId);
  //     setState(() {
  //       requestDiscounts = listDiscounts;
  //     });
  //   } finally {
  //     EasyLoading.dismiss();
  //     setState(() => isLoading = false);
  //   }
  // }

  List<Item> options = [
    Item(
        id: "discounts",
        icon: Icons.home,
        title: 'Descuentos',
        isSelected: true),
    Item(
        id: "discounts-approved",
        icon: Icons.home,
        title: 'Aprobados',
        isSelected: false),
    Item(
        id: "discounts-rejected",
        icon: Icons.home,
        title: 'Rechazados',
        isSelected: false),
  ];

  late Item itemSelected;
  @override
  void initState() {
    super.initState();
    // fetchRequestedDiscounts();
    itemSelected = options.first;
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: const [],
        appBar: CustomAppBarTitle(title: "Aprobaciones de descuento"),
        child: Column(
          children: [
            TopSelectorScreen(
                items: options,
                onTapOption: (p0) {
                  setState(() {
                    itemSelected = p0;
                  });
                }),
            SizedBox(height: 10),
            if (itemSelected.id == "discounts") DiscountsByResolutionScreen(),
            if (itemSelected.id == "discounts-approved") DiscountsApprovedScreen(),
            if (itemSelected.id == "discounts-rejected") DiscountsRejectedScreen(),
          ],
        ));
  }
}
