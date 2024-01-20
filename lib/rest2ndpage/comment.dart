import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final String time;

  // Correct the constructor syntax
  const Comment({
    Key? key,
    required this.user,
    required this.text,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all (15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //comment
          Text (text),
         const SizedBox(height: 5),
         //user, time
          Row(
            children: [
              Text (user, style: TextStyle (color: Colors.blueGrey),
              ),
              Text (".", style: TextStyle (color: Colors.blueGrey)),
              Align(
                alignment: Alignment.centerRight,
                widthFactor: 1.8,
                child: Text(
                  time,
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ),



            ],
          ),

    ],
      ),
    );
  }
}
