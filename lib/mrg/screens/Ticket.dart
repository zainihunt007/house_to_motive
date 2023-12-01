import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color.dart';
import '../constants/list.dart';
import '../widgets/ticketCard.dart';
import '../widgets/ticketTile.dart';
import 'Favourites/myfavourite.dart';

class ticketScreens extends StatelessWidget {
  const ticketScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F9FF),
      appBar: AppBar(
        backgroundColor: seagreen,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
           // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFavourites()));
          },
        ),
        flexibleSpace: Image(
          image: AssetImage('assets/assets2/images/Pasted image.png'),
          fit: BoxFit.cover,
        ),
        title: Text('My Tickets',
            style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return TicketTile(
                context,
                Name2[index],
                date[index],
                price[index],
                member[index],
                loc[index],
                Category1[index],
                Category2[index],
                disc[index]);
          },
        ),
      ),
    );
  }
}
