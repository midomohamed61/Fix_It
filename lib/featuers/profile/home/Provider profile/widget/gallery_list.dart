import 'package:flutter/material.dart';

class GalleryList extends StatelessWidget {
  const GalleryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (_, index) => Container(
          margin: const EdgeInsets.only(right: 8),
          width: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              //repet this image 5 times horizontally
              image: AssetImage('assets/images/image 84.png'),
              repeat: ImageRepeat.repeatX,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
