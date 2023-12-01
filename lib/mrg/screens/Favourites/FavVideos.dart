import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/list.dart';

class FavVideos extends StatelessWidget {
  const FavVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: VideoIMg.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage(VideoIMg[index]),
                          fit: BoxFit.fill)),
                ),
                Center(
                  child: Image.asset(
                    'assets/assets2/Video_images/platbtn.png',
                    height: 2.5.h,
                    width: 2.5.h,
                  ),
                )
              ],
            );
          }),
    );
  }
}
