import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Color(0xff025B8F),
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Image.asset('assets/pngs/htmlogo.png'),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/appbar/Vector@2x.png',
                  height: 9,
                  width: 9,
                ),
                SizedBox(width: 1.h),
                Text(
                  'My Location',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 1.h),
                  Text(
                    '73 Newport Road, Carnbo',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(width: 1.h),
                  Image.asset(
                    'assets/appbar/Vector1.png',
                    height: 9,
                    width: 9,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          SvgPicture.asset('assets/appbar/heart.svg'),
          SizedBox(width: 1.w),
          SvgPicture.asset('assets/appbar/Notification.svg'),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 1.6.w),
              SizedBox(
                height: 7.h,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search what’s near me",
                    hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xff424B5A),),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/svgs/search-normal.svg',
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      'Recent Searches',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xff025B8F),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          SvgPicture.asset('assets/svgs/iconoir_refresh.svg'),
                      title: Text(
                        'Lorem ipsum',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7390A1),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                          'assets/svgs/radix-icons_cross-2.svg'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Container(
          width: 4.8.h,
          height: 4.8.w,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xffFF0092),
                Color(0xff216DFD),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
