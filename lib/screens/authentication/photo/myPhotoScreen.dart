import 'package:flutter/material.dart';
import 'package:internship0006/screens/authentication/photo/animationDialog.dart';

List<String> _imageUrlList = [
  'https://live.staticflickr.com/8506/8407172630_18d28a2ed3_c_d.jpg',
  'https://live.staticflickr.com/8330/8406212067_4802ee432c_c_d.jpg',
  'https://live.staticflickr.com/8328/8406290529_a422ef077b_c_d.jpg',
  'https://live.staticflickr.com/8071/8407417316_2b09fe27cf_c_d.jpg',
  'https://live.staticflickr.com/8226/8407445386_dd416a558b_c_d.jpg',
  'https://live.staticflickr.com/8046/8407446162_2c8331fde8_c_d.jpg',
  'https://live.staticflickr.com/8334/8407459084_c59da3d8e0_c_d.jpg',
  'https://live.staticflickr.com/8370/8406368213_b44c3c5e53_c_d.jpg',
  'https://live.staticflickr.com/8237/8406383473_d4552a1cb9_c_d.jpg',
  'https://live.staticflickr.com/8323/8407506118_915f7fb1a1_c_d.jpg',
  'https://live.staticflickr.com/8077/8406419819_9530514a87_c_d.jpg',
  'https://live.staticflickr.com/8048/8406431731_6a3962958d_c_d.jpg',
  'https://live.staticflickr.com/8329/8406514685_2473bd6e90_c_d.jpg',
  'https://live.staticflickr.com/8506/8407172630_18d28a2ed3_c_d.jpg',
  'https://live.staticflickr.com/8330/8406212067_4802ee432c_c_d.jpg',
  'https://live.staticflickr.com/8328/8406290529_a422ef077b_c_d.jpg',
  'https://live.staticflickr.com/8071/8407417316_2b09fe27cf_c_d.jpg',
  'https://live.staticflickr.com/8226/8407445386_dd416a558b_c_d.jpg',
  'https://live.staticflickr.com/8046/8407446162_2c8331fde8_c_d.jpg',
  'https://live.staticflickr.com/8334/8407459084_c59da3d8e0_c_d.jpg',
  'https://live.staticflickr.com/8370/8406368213_b44c3c5e53_c_d.jpg',
  'https://live.staticflickr.com/8237/8406383473_d4552a1cb9_c_d.jpg',
  'https://live.staticflickr.com/8323/8407506118_915f7fb1a1_c_d.jpg',
  'https://live.staticflickr.com/8077/8406419819_9530514a87_c_d.jpg',
  'https://live.staticflickr.com/8048/8406431731_6a3962958d_c_d.jpg',
  'https://live.staticflickr.com/8329/8406514685_2473bd6e90_c_d.jpg',
  'https://www.cnet.com/a/img/-qQkzFVyOPEoBRS7K5kKS0GFDvk=/940x0/2020/04/16/7d6d8ed2-e10c-4f91-b2dd-74fae951c6d8/bazaart-edit-app.jpg',
  'https://www.blog.motifphotos.com/wp-content/uploads/2020/01/Edit-photos-768x527.jpg'
];

class MyPhotoScreen extends StatefulWidget {
  MyPhotoScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyPhotoScreenState createState() => _MyPhotoScreenState();
}

class _MyPhotoScreenState extends State<MyPhotoScreen> {
  final snackBar = SnackBar(content: Text('Image is tapped.'));

  OverlayEntry? _popupDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "My Photo"),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        children: _imageUrlList.map(_createGridTileWidget).toList(),
      ),
      
    );
  }

  Widget _createGridTileWidget(String url) => Builder(
        builder: (context) => GestureDetector(
          onLongPress: () {
            _popupDialog = _createPopupDialog(url);
            Overlay.of(context)!.insert(_popupDialog!);
          },
          onLongPressEnd: (details) => _popupDialog?.remove(),
          child: Image.network(url, fit: BoxFit.cover),
        ),
      );

  OverlayEntry _createPopupDialog(String url) {
    return OverlayEntry(
      builder: (context) => AnimatedDialog(
        child: _createPopupContent(url),
      ),
    );
  }

  Widget _createPopupContent(String url) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _createPhotoTitle(),
              Image.network(url, fit: BoxFit.fitWidth),
            ],
          ),
        ),
      );

  Widget _createPhotoTitle() => Container(
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Text('this is a large image',
            style: TextStyle(color: Colors.white)),
      );
}
