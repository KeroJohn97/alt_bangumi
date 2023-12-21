// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:alt_bangumi/helpers/sizing_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:alt_bangumi/constants/http_constant.dart';
import 'package:alt_bangumi/gen/assets.gen.dart';
import 'package:alt_bangumi/helpers/common_helper.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final _height = 150.0;
  double? _width;

  @override
  void initState() {
    super.initState();
    _width = 100.w;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: CarouselSlider(
        items: [
          GestureDetector(
            onTap: () async => CommonHelper.showInBrowser(
              context: context,
              url: '${HttpConstant.host}/award/2018',
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Assets.images.static.almanac1.image(
                  height: _height,
                  width: _width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async => CommonHelper.showInBrowser(
              context: context,
              url: '${HttpConstant.host}/award/2019',
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Assets.images.static.almanac2.image(
                  height: _height,
                  width: _width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async => CommonHelper.showInBrowser(
              context: context,
              url: '${HttpConstant.host}/award/2020',
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Assets.images.static.almanac3.image(
                  height: _height,
                  width: _width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async => CommonHelper.showInBrowser(
              context: context,
              url: '${HttpConstant.host}/award/2021',
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Assets.images.static.almanac4.image(
                  height: _height,
                  width: _width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
