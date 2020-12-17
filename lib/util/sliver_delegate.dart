import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;


  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background image
          Container(child: Image.network(this.coverImgUrl, fit: BoxFit.cover)),
          // Put your head back
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
                color: Colors.black12, // Background color
            child: SafeArea(
              bottom: false,
              child: Container(
                height: this.collapsedHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black, // Return icon color
                ),
                onPressed: () => Navigator.pop(context),
              ),
              Text(
                this.title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color:Colors.orange, // Title color
              ),
            ),
            IconButton(
              icon: Icon(
                  Icons.share,
                  color: Colors.red, // Share icon color
            ),
            onPressed: () {},
          ),
        ],
      ),
    ),
    ),
    ),
    ),
    ],
    ),
    );
  }
}