import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String image;
  VoidCallback navigate;

  CategoryItem({ this.navigate,
     this.title,
     this.color,
     this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: navigate,
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),),
        footer: GridTileBar(
          backgroundColor: color.withOpacity(0.8),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
