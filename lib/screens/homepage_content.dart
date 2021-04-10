import 'package:clothes/widgets/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  double xoffset = 0;

  double yoffset = 0;

  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xoffset, yoffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? 0.2 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            bottomLeft:
                isDrawerOpen ? Radius.circular(50) : Radius.circular(0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FadeAnimation(
              1,
              Container(
                height: MediaQuery.of(context).size.height * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isDrawerOpen ? 50 : 0)),
                    image: DecorationImage(
                        image: AssetImage('images/shoes/shoes6.jpg'),
                        fit: BoxFit.cover),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.7),
                          Colors.black.withOpacity(.2)
                        ])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isDrawerOpen
                              ? IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    setState(() {
                                      xoffset = 0;
                                      yoffset = 0;
                                      scaleFactor = 1;
                                      isDrawerOpen = false;
                                    });
                                  })
                              : FadeAnimation(
                                  1,
                                  IconButton(
                                      icon:
                                          FaIcon(FontAwesomeIcons.alignCenter),
                                      color: Colors.white,
                                      iconSize: 30,
                                      onPressed: () {
                                        setState(() {
                                          xoffset = 230;
                                          yoffset = 150;
                                          scaleFactor = 0.6;
                                          isDrawerOpen = true;
                                        });
                                      }),
                                ),
                          Row(
                            children: [
                              FadeAnimation(
                                1,
                                IconButton(
                                    icon: Icon(Icons.favorite_outline),
                                    color: Colors.white,
                                    iconSize: 30,
                                    onPressed: () {}),
                              ),
                              FadeAnimation(
                                1,
                                IconButton(
                                    icon: Icon(Icons.shopping_cart_outlined),
                                    color: Colors.white,
                                    iconSize: 30,
                                    onPressed: () {}),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeAnimation(
                              1.1,
                              Text(
                                'Our New products',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FadeAnimation(
                              1.1,
                              Container(
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.(40),
                                  border: Border.all(color: Colors.white),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * .04,
                                width: MediaQuery.of(context).size.width * .3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FadeAnimation(
                                      1.1,
                                      Text(
                                        'View More'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                    ),
                                    FadeAnimation(
                                      1.2,
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeAnimation(
                    1.3,
                    Text(
                      'Categories',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      'All',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FadeAnimation(
                1.3,
                Container(
                  height: MediaQuery.of(context).size.height * .19,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      makeCateory('images/jeans/jeans10.jpg', 'Jeans'),
                      makeCateory('images/hoodie/hoodie6.jpg', 'Hoodies'),
                      makeCateory('images/shoes/shoes1.jpg', 'shoes'),
                      makeCateory('images/tshirts/tshirt1.jpg', 'T-shirts'),
                      makeCateory('images/icons/jacket1.jpg', 'Jackets'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FadeAnimation(
                    1.4,
                    Text(
                      'Best Selling by Category',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FadeAnimation(
                    1.4,
                    Text(
                      'All',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FadeAnimation(
                1.5,
                Container(
                  height: MediaQuery.of(context).size.height * .19,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      makeBestSellingCategory(
                          'images/jeans/jeans9.jpg', 'Jeans'),
                      makeBestSellingCategory(
                          'images/hoodie/hoodie3.jpg', 'Hoodies'),
                      makeBestSellingCategory(
                          'images/shoes/shoes3.jpg', 'shoes'),
                      makeBestSellingCategory(
                          'images/tshirts/tshirt7.jpg', 'T-shirts'),
                      makeBestSellingCategory(
                          'images/icons/jacket2.jpg', 'Jackets'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeBestSellingCategory(image, title) {
    return AspectRatio(
      aspectRatio: 2 / 1.5,
      child: FadeAnimation(
        1.5,
        Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
          child: FadeAnimation(
            1.5,
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.0)
                      ])),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeCateory(image, title) {
    return AspectRatio(
      aspectRatio: 2 / 2.2,
      child: FadeAnimation(
        1.4,
        Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
          child: FadeAnimation(
            1.4,
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.0)
                      ])),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
