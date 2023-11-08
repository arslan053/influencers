import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:influencer/src/Utils/ProfileCard.dart';


class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Image.asset('assets/images/celebrity.png',fit: BoxFit.cover,)),
                const SizedBox(height: 20,),
              Column(
                children: [
                   Text(
    'Natasha',
    style: TextStyle(
      fontSize: 24,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w700,
      height: 0,
    ),
  ),
  Text(
    'Fasion & Lifestyle',
    style: TextStyle(
      color: Color(0xFF7F8080),
      fontSize: 10,
      fontFamily: 'Ubuntu',
      fontWeight: FontWeight.w700,
      height: 0,
    ),
  ),
                ],
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('Instagram Insight',style: TextStyle(fontFamily: GoogleFonts.ubuntu.toString(),fontSize: 18, fontWeight: FontWeight.w600),)),
                const SizedBox(height: 8,),
                const ProfileCard(),
                const SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'About User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 6,),
                const SizedBox(
                width: 335,
                height: 46,
                child: Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using le English.',
                  style: TextStyle(
                    color: Color(0xFF7F8080),
                    fontSize: 10,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                ),
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '46 Reviews',
                    style: TextStyle(
                      // color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '4.8',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Icon(Icons.star,color: Colors.yellow,size: 10,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 300,
                padding: EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context , index){
                    return ListTile(
                      leading: Container(
                        height: 30,
                        width: 30,
                        child: Image.asset('assets/images/celebrity.png')),
                      title: Text(
                        'Emily Watson',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      subtitle: Text(
                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters',
                        style: TextStyle(
                          color: Color(0xFF7F8080),
                          fontSize: 10,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '4.8',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                            height: 0,
                          ),
                        ),
                        Icon(Icons.star,color: Colors.yellow,size: 10,),
                      ],
                    ),
                    );
                }),
              )
              ],
          ),
        ),
      ),
    );
  }
}