import 'package:flutter/material.dart';

class ReusableRow extends StatefulWidget {
  const ReusableRow({
    super.key,
    required this.title1,
    required this.value1,
    required this.image1,
    required this.title2,
    required this.value2,
    required this.image2,
  });

  final String title1;
  final String value1;
  final String image1;
  final String title2;
  final String value2;
  final String image2;

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(widget.image1, width: 50, height: 50, scale: 8),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title1,
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  widget.value1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(widget.image2, width: 50, height: 50, scale: 8),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title2,
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  widget.value2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
