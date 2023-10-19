import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/views/quotes/pages/quote_unit_status_page.dart';
import 'package:flutter/material.dart';

class TopSelectorScreen extends StatefulWidget {
  final List<Item> items;
  final Function(Item) onTapOption;
  const TopSelectorScreen(
      {Key? key, required this.items, required this.onTapOption})
      : super(key: key);

  @override
  _TopSelectorScreenState createState() => _TopSelectorScreenState();
}

class _TopSelectorScreenState extends State<TopSelectorScreen> {
  void selectItem(int index) {
    setState(() {
      for (int i = 0; i < widget.items.length; i++) {
        if (i == index) {
          widget.items[i].isSelected = true;
        } else {
          widget.items[i].isSelected = false;
        }
      }
    });
  }

  // late Item itemSelected;
  // @override
  // void initState() {
  //   super.initState();

  //   itemSelected = widget.items.first;
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.items
            .map(
              (item) => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      selectItem(widget.items.indexOf(item));
                      widget.onTapOption(item);
                      // quoteConsultPageController.update();
                      // itemSelected = item;
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: item.isSelected
                            ? AppColors.softMainColor
                            : AppColors.secondaryMainColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            item.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
