import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../views/screens/home_screens/home_model.dart';

class FavEvents extends StatelessWidget {
  const FavEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: SingleChildScrollView(
          child: Column(
            children: itemList.map((item) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      height: screenHeight * 0.32,
                      width: screenWidth / 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title']!,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    GradientText(
                                      text: "+200 Going",
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xffFF0092),
                                          Color(0xff216DFD),
                                        ],
                                      ),
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svgs/home/map-pin.svg'),
                                    const SizedBox(width: 3),
                                    Text(
                                      item['description']!,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff7390A1),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image.asset('assets/pngs/Vector.png'),
                                    const SizedBox(width: 3),
                                    Text(
                                      'Trending',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: const Color(0xff025B8F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset(
                                        'assets/pngs/material-symbols_upcoming-outline.png'),
                                    const SizedBox(width: 3),
                                    Text(
                                      'Trending',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: const Color(0xff025B8F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                        'assets/pngs/majesticons_music.png'),
                                    const SizedBox(width: 3),
                                    Text(
                                      'Hip-hop',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: const Color(0xff025B8F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset(
                                        'assets/pngs/majesticons_music-line.png'),
                                    const SizedBox(width: 3),
                                    Text(
                                      'Hot',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: const Color(0xff025B8F),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.25,
                    width: Get.width / 1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          // foodnearby[index].image,
                          item['image']!,
                        ),
                      ),
                      // color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff80FFFFFF),
                            radius: 16,
                            child:
                            SvgPicture.asset('assets/svgs/home/Vector.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
