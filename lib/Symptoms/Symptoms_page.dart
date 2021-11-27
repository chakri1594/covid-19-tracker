import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:covid_19_tracker/Symptoms/data.dart';

// ignore: must_be_immutable
class Symptoms extends StatelessWidget {
  final controller = PageController(
    initialPage: 0,
  );

  final imgPath;

  final Color color;


  Symptoms({Key key, this.imgPath, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 28,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          //Cover Image Container
          Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              color: color.withOpacity(0.2),
            ),
            width: MediaQuery.of(context).size.width,
            child: LayoutBuilder(
              builder: (ctx, constraint) => Stack(
                children: <Widget>[
                  //Title
                  Positioned(
                    top: constraint.maxHeight * 0.45,
                    left: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: constraint.maxWidth * 0.55,
                        child: AutoSizeText(
                          "Symptoms",
                          style: TextStyle(
                            color: color,
                            fontFamily: "Montserrat",
                            fontSize: 31,
                            fontWeight: FontWeight.w700,
                          ),
                          stepGranularity: 1,
                          maxFontSize: 31,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),

                  //Image
                  Positioned.fill(
                    bottom: -17.0,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.only(right: 17.0),
                        child: LayoutBuilder(
                          builder: (ctx, constraint) => Hero(
                            tag: imgPath,
                            child: Image(
                              image: AssetImage(imgPath),
                              height: constraint.maxHeight * 0.83,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Myth card
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 15),
              width: MediaQuery.of(context).size.width > 360.0
                  ? MediaQuery.of(context).size.width - 31.0
                  : MediaQuery.of(context).size.width,
              child: Material(
                borderRadius: BorderRadius.circular(15.0),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    //Details
                    Flexible(
                      fit: FlexFit.loose,
                      child: PageView.builder(
                          controller: controller,
                          physics: BouncingScrollPhysics(),
                          itemCount: info.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(23, 35, 23, 15),
                              child: LayoutBuilder(
                                builder: (ctx, constraint) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    LimitedBox(
                                      maxHeight: constraint.maxHeight*0.40,
                                      child: Image(
                                        image: AssetImage(
                                            info[index].iconImage),

                                        height: 150.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraint.maxHeight*0.11,
                                    ),
                                    LimitedBox(
                                      maxHeight: constraint.maxHeight*0.17,
                                      child: AutoSizeText(
                                        info[index].name,

                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 19,
                                          height: 1.1,
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxFontSize: 20,
                                        stepGranularity: 2,
                                        maxLines: 3,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    LimitedBox(
                                      maxHeight: constraint.maxHeight*0.45,
                                      child: AutoSizeText(
                                        info[index].description,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          height: 1.4,
                                          fontFamily: "Montserrat",
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxFontSize: 16.5,
                                        stepGranularity: 1.5,
                                        maxLines: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),

                    //Dot Indicator
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: info.length,
                        effect: WormEffect(
                            dotHeight: 11,
                            dotWidth: 11,
                            spacing: 12.0,
                            strokeWidth: 1.2,
                            dotColor: Colors.grey[400],
                            paintStyle: PaintingStyle.stroke,
                            activeDotColor: Color(0xFF1B8D59)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
