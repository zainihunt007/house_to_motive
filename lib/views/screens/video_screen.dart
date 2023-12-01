import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});
  void _shareContent() {
    Share.share('house_to_motive');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/pic.png',
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                      const Text(
                        'What’s near me ',
                        style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffDADADA)),
                      ),
                      const Text(
                        'Based on Likes',
                        style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xffDADADA)),
                      ),
                      SvgPicture.asset('assets/svgs/Search icon.svg'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: AutoSizeText(
                                  maxLines: 1,
                                  'Lorem Lipsum',
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '@NQ64 ARCADE',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Opening Time : 10: am to 2:00 AM',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Starting Price: \$9.99',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Image.asset('assets/pngs/Location.png'),
                              const SizedBox(width: 10),
                              Text(
                                'Stratford,London',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Stack(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                  backgroundImage:
                                      AssetImage('assets/images/3.jpg'),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                right: 10,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      'assets/pngs/Subscribe button.png'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            width: 46,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/svgs/Like icon.svg'),
                                Text(
                                  '256',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white60,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            width: 46,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Image.asset('assets/pngs/comments.png'),
                                Text(
                                  '256',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white60,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 60,
                            width: 46,
                            // color: Colors.red,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _shareContent();
                                  },
                                  child: Image.asset('assets/pngs/share.png'),
                                ),
                                Text(
                                  '256',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white60,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
