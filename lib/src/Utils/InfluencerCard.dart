import 'package:flutter/material.dart';

class InfluencerCard extends StatelessWidget {
  final String path;
  final String category;
  final String rating;
  final String name;
  final String order;
  const InfluencerCard({Key? key, required this.path, required this.category, required this.rating, required this.name, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 167,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            height: 173,
            child: Image.asset(path),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(category,style: TextStyle(fontSize: 12,color: Colors.grey),),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        Text(rating,style: TextStyle(fontSize: 12,color: Colors.black),),
                        Icon(Icons.star,color: Colors.yellow,size: 25,)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Text(name,style: TextStyle(fontSize: 12,color: Colors.black),),
                SizedBox(height: 4,),
                Text('$order order completed',style: TextStyle(fontSize: 12,color: Colors.grey),),
              ],
            ),
          )
        ],
      ),
    );
  }
}