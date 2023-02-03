import 'package:flutter/material.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../constants/theme.dart';
import '../../widgets/input.dart';

class NavbarEvent extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String>? tags;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final Function? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  NavbarEvent(
      {this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = ArgonColors.white,
      this.searchBar = false});

  final double _prefferedHeight = 180.0;

  @override
  _NavbarEventState createState() => _NavbarEventState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarEventState extends State<NavbarEvent> {
  late String activeTag;

  void initState() {
    if (widget.tags != null && widget.tags?.length != 0) {
      activeTag = widget.tags![0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags?.length == 0 ? false : true);

    return Container(
        // height: widget.searchBar
        //     ? (!categories
        //         ? (tagsExist ? 211.0 : 178.0)
        //         : (tagsExist ? 262.0 : 210.0))
        //     : (!categories
        //         ? (tagsExist ? 162.0 : 102.0)
        //         : (tagsExist ? 200.0 : 150.0)),
        decoration: BoxDecoration(
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? ArgonColors.initial
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                            !widget.backButton
                                ? Icons.menu
                                : Icons.arrow_back_ios,
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            size: 24.0),
                        onPressed: () {
                          if (!widget.backButton)
                            Scaffold.of(context).openDrawer();
                          else
                            Navigator.pop(context);
                        }),
                    Text(widget.title,
                        style: TextStyle(
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0)),
                  ],
                ),

                if (widget.searchBar)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(                                        
                        child: Input(                          
                            placeholder: "Tìm Kiếm Sự Kiện",
                            controller: widget.searchController,
                            onChanged: widget.searchOnChanged,
                            // autofocus: widget.searchAutofocus,
                            // suffixIcon:                            
                            //     const Icon(Icons.zoom_in, color: ArgonColors.muted, size: 50.0,),
                            onTap: () {
                              Navigator.pushNamed(context, '/pro');
                            },
                            prefixIcon: Icon(Icons.design_services_sharp)),
                      ),
                      PopupMenuButton<int>(
                          icon: Icon(Icons.filter_alt_outlined),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.access_time_sharp, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('Ngày gần nhất'),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 2,
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.delete, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text('Mới nhất'),
                                    ),
                                  ],
                                ),
                              ),
                            ];
                          }),
                    ],
                  ),

                SizedBox(
                  height: 22.0,
                ),

                if (categories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //Navigator.pushNamed(context, '/pro');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera,
                                color: ArgonColors.initial, size: 22.0),
                            SizedBox(width: 10),
                            Text(widget.categoryOne,
                                style: TextStyle(
                                    color: ArgonColors.initial,
                                    fontSize: 16.0)),
                          ],
                        ),
                      ),
                      Container(
                        color: ArgonColors.initial,
                        height: 25,
                        width: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          //Navigator.pushNamed(context, '/pro');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.school,
                                color: ArgonColors.initial, size: 22.0),
                            SizedBox(width: 10),
                            Text(widget.categoryTwo,
                                style: TextStyle(
                                    color: ArgonColors.initial,
                                    fontSize: 16.0)),
                          ],
                        ),
                      )
                    ],
                  ),
                //if (tagsExist)
                // Container(
                //   height: 40,
                //   child: ScrollablePositionedList.builder(
                //     itemScrollController: _scrollController,
                //     scrollDirection: Axis.horizontal,
                //     itemCount: widget.tags.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return GestureDetector(
                //         onTap: () {
                //           if (activeTag != widget.tags[index]) {
                //             setState(() => activeTag = widget.tags[index]);
                //             _scrollController.scrollTo(
                //                 index:
                //                     index == widget.tags.length - 1 ? 1 : 0,
                //                 duration: Duration(milliseconds: 420),
                //                 curve: Curves.easeIn);
                //             if (widget.getCurrentPage != null)
                //               widget.getCurrentPage(activeTag);
                //           }
                //         },
                //         child: Container(
                //             margin: EdgeInsets.only(
                //                 left: index == 0 ? 46 : 8, right: 8),
                //             padding: EdgeInsets.only(
                //                 top: 4, bottom: 4, left: 20, right: 20),
                //             // width: 90,
                //             decoration: BoxDecoration(
                //                 color: activeTag == widget.tags[index]
                //                     ? ArgonColors.primary
                //                     : ArgonColors.secondary,
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(4.0))),
                //             child: Center(
                //               child: Text(widget.tags[index],
                //                   style: TextStyle(
                //                       color: activeTag == widget.tags[index]
                //                           ? ArgonColors.white
                //                           : ArgonColors.black,
                //                       fontWeight: FontWeight.w600,
                //                       fontSize: 14.0)),
                //             )),
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
