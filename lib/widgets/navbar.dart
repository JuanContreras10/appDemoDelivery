import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:tienda/constants/MilistaCarrito.dart';
import 'package:tienda/constants/Theme.dart';
//import 'package:tienda/constants/clases.dart';

import 'package:tienda/newScreens/carrito.dart';
//import 'package:tienda/newScreens/registro.dart';

// import 'package:tienda/screens/categories.dart';
// import 'package:tienda/screens/best-deals.dart';
// import 'package:tienda/screens/search.dart';
// import 'package:tienda/screens/cart.dart';
// import 'package:tienda/screens/chat.dart';

import 'package:tienda/widgets/input.dart';

//CarritoList ubo = new CarritoList("1", "2", "3", "4", "5");

//List listCarrito = [];

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String> tags;
  final Function getCurrentPage;
  final bool isOnSearch;
  final TextEditingController searchController;
  final Function searchOnChanged;
  final Function searchOnTap;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;
  final bool animationAppbar;

  Navbar({
    this.title = "Alexander Palacios",
    this.categoryOne = "",
    this.categoryTwo = "",
    this.tags,
    this.transparent = false,
    this.rightOptions = true,
    this.getCurrentPage,
    this.searchController,
    this.isOnSearch = false,
    this.searchOnChanged,
    this.searchOnTap,
    this.searchAutofocus = false,
    this.backButton = false,
    this.noShadow = false,
    this.bgColor = Colors.white,
    this.searchBar = false,
    this.animationAppbar = false,
  });

  final double _prefferedHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}

class _NavbarState extends State<Navbar> {
  String activeTag;

  ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    if (widget.tags != null && widget.tags.length != 0) {
      activeTag = widget.tags[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist =
        widget.tags == null ? false : (widget.tags.length == 0 ? false : true);
    final instanciaLista = Provider.of<MilistaCarrito>(context);

    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: widget.animationAppbar
            ? widget.searchBar
                ? (!categories
                    ? (tagsExist ? 211.0 : 178.0)
                    : (tagsExist ? 262.0 : 210.0))
                : (!categories
                    ? (tagsExist ? 132.0 : 102.0)
                    : (tagsExist ? 200.0 : 150.0))
            : 0.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(
                  25.0), //                 <--- border radius here
            ),
            color: !widget.transparent ? widget.bgColor : Colors.transparent,
            boxShadow: [
              BoxShadow(
                  color: !widget.transparent && !widget.noShadow
                      ? Colors.black.withOpacity(0.6)
                      : Colors.transparent,
                  spreadRadius: -10,
                  blurRadius: 12,
                  offset: Offset(0, 5))
            ]),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                  !widget.backButton
                                      ? Icons.menu
                                      : Icons.arrow_back_ios,
                                  color: !widget.transparent
                                      ? (widget.bgColor == Colors.white
                                          ? Colors.black
                                          : Colors.white)
                                      : Colors.white,
                                  size: 24.0),
                              onPressed: () {
                                if (!widget.backButton)
                                  Scaffold.of(context).openDrawer();
                                else
                                  Navigator.pushNamed(context, '/home');
                              }),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(widget.title,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: !widget.transparent
                                        ? (widget.bgColor == Colors.white
                                            ? Colors.black
                                            : Colors.white)
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0)),
                          ),
                        ],
                      ),
                      if (widget.rightOptions)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Chat()));
                              },
                              child: IconButton(
                                  icon: Icon(Icons.chat_bubble_outline,
                                      color: !widget.transparent
                                          ? (widget.bgColor == Colors.white
                                              ? Colors.black
                                              : Colors.white)
                                          : Colors.white,
                                      size: 22.0),
                                  onPressed: null),
                            ),
                            GestureDetector(
                              child: Container(
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(),
                                ),
                                child: Stack(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showBarModalBottomSheet(
                                            elevation: 10.0,
                                            duration:
                                                Duration(milliseconds: 900),
                                            bounce: true,
                                            expand: true,
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) => Carrito(),
                                          );
                                          print(instanciaLista.myList.length);
                                        },
                                        icon: Icon(Icons.shopping_cart_outlined,
                                            color: !widget.transparent
                                                ? (widget.bgColor ==
                                                        Colors.white
                                                    ? Colors.black
                                                    : Color.fromRGBO(
                                                        241, 196, 15, 1))
                                                : Color.fromRGBO(
                                                    241, 196, 15, 1),
                                            size: 22.0),
                                      ),
                                      instanciaLista.tamanio == 0
                                          ? Container()
                                          : Container(
                                              width: 25.0,
                                              height: 25.0,
                                              child: Center(
                                                child: Text(
                                                    "${instanciaLista.tamanio}",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              decoration: new BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                            )
                                    ]),
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                  if (widget.searchBar)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 4, left: 15, right: 15),
                      child: Input(
                        placeholder: "Que estas buscando?",
                        controller: widget.searchController,
                        onChanged: widget.searchOnChanged,
                        onTap: widget.searchOnTap,
                        autofocus: widget.searchAutofocus,
                        outlineBorder: true,
                        textColor: Colors.white,
                        enabledBorderColor:
                            Colors.white, //Colors.black.withOpacity(0.2),
                        focusedBorderColor:
                            Colors.white, //,MaterialColors.muted,
                        suffixIcon: Icon(Icons.zoom_in,
                            color: Colors.white), //MaterialColors.muted),
                      ),
                    ),
                  SizedBox(
                    height: tagsExist ? 0 : 10,
                  ),
                  if (categories)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Categories()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.border_all,
                                  color: Colors.black87, size: 22.0),
                              SizedBox(width: 10),
                              Text(widget.categoryOne,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0)),
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        Container(
                          color: MaterialColors.muted,
                          height: 25,
                          width: 0.3,
                        ),
                        SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => BestDeals()));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.camera_enhance,
                                  color: Colors.black87, size: 22.0),
                              SizedBox(width: 10),
                              Text(widget.categoryTwo,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0)),
                            ],
                          ),
                        )
                      ],
                    ),
                  if (tagsExist)
                    Container(
                      height: 40,
                      child: ScrollablePositionedList.builder(
                        itemScrollController: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.tags.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              if (activeTag != widget.tags[index]) {
                                setState(() => activeTag = widget.tags[index]);
                                _scrollController.scrollTo(
                                    index:
                                        index == widget.tags.length - 1 ? 1 : 0,
                                    duration: Duration(milliseconds: 420),
                                    curve: Curves.easeIn);
                                if (widget.getCurrentPage != null)
                                  widget.getCurrentPage(activeTag);
                              }
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? 46 : 8, right: 8),
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2.0,
                                            color:
                                                activeTag == widget.tags[index]
                                                    ? MaterialColors.primary
                                                    : Colors.transparent))),
                                child: Center(
                                  child: Text(widget.tags[index],
                                      style: TextStyle(
                                          color: activeTag == widget.tags[index]
                                              ? MaterialColors.primary
                                              : MaterialColors.placeholder,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0)),
                                )),
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          ),
        ));
  }
}
