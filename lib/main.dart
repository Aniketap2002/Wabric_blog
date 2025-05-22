import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';

void main() => runApp(WabricBlogApp());
String _currentSubtitle = "WHITE SHIRT";

class WabricBlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WabricBlogPage(),
    );
  }
}

class WabricBlogPage extends StatefulWidget {
  @override
  _WabricBlogPageState createState() => _WabricBlogPageState();
}

class _WabricBlogPageState extends State<WabricBlogPage> {
  final _keyWhiteShirt = GlobalKey();
  final _keyScarfJacket = GlobalKey();
  final _keyModel2 = GlobalKey();
  final _keyModel3 = GlobalKey();

  ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      setState(() {
        _isScrolled = offset > 200;

        if (offset < 600) {
          _currentSubtitle = "WHITE SHIRT";
        } else if (offset < 1200) {
          _currentSubtitle = "SCARF AND JACKET";
        } else if (offset < 1800) {
          _currentSubtitle = "MODEL TWO";
        } else {
          _currentSubtitle = "MODEL THREE";
        }
      });
    });
  }

  Widget _buildHeader() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      top: _isScrolled ? 0 : 50,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: 1.0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/logo.png", height: 30),
                  SizedBox(height: 4),
                  Text(
                    _currentSubtitle.toUpperCase(),
                    style: TextStyle(fontSize: 12, letterSpacing: 1.5),
                  ),
                ],
              ),
              Image.asset("assets/menu.png", height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String image,
    required String subtitle,
    bool isTextLeft = true,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero),
      duration: Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: Offset(0, offset.dy * 100),
          child: Opacity(
            opacity: 1 - offset.dy,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 80),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isTextLeft) ...[
                        Expanded(child: _buildTextBlock(title, subtitle)),
                        SizedBox(width: 40),
                        Expanded(child: Image.asset(image)),
                      ] else ...[
                        Expanded(child: Image.asset(image)),
                        SizedBox(width: 40),
                        Expanded(child: _buildTextBlock(title, subtitle)),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextBlock(String heading, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Text(body, style: TextStyle(fontSize: 18, height: 1.5)),
      ],
    );
  }

  Widget _buildVisualSection(String heading, List<String> imagePaths) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/logo.png", height: 40),
          SizedBox(height: 4),
          Text(
            heading.toUpperCase(),
            style: TextStyle(fontSize: 12, letterSpacing: 1.5),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                imagePaths
                    .map(
                      (img) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(img),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    _buildSection(
                      title: "The Legacy of Iconic Designs",
                      image: "assets/model1.png",
                      subtitle:
                          "A timeless celebration of fashion with bold identity.",
                      isTextLeft: true,
                    ),
                    _buildVisualSection("Scarf and Jacket", [
                      "assets/scarf.png",
                      "assets/jacket.png",
                    ]),
                    _buildSection(
                      title: "True Style Wears Fabric",
                      image: "assets/model2.png",
                      subtitle:
                          "Each thread tells a story of elegance and comfort.",
                      isTextLeft: false,
                    ),
                    _buildSection(
                      title: "Legendary Fashion Pieces That Define Elegance",
                      image: "assets/model3.png",
                      subtitle:
                          "Explore iconic looks that set standards in global fashion.",
                      isTextLeft: true,
                    ),
                    SizedBox(height: 300),
                    Text(
                      "WHERE EVERY HEART BELONGS",
                      style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
              _buildHeader(),
            ],
          );
        },
      ),
    );
  }
}
