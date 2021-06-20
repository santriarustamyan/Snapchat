import 'package:flutter/material.dart';

class AnimationPhotoHero extends StatelessWidget {
  const AnimationPhotoHero({
    Key? key,
    this.photo,
    this.width,
  }) : super(key: key);
  final String? photo;
  final double? width;
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: GestureDetector(
          child: Hero(
            tag: photo!,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                autofocus: false,
                child: Image.asset(
                  photo!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ));
  }
}

// class Photo extends StatelessWidget {
//   Photo({ Key key, this.photo, this.color, this.onTap }) : super(key: key);

//   final String photo;
//   final Color color;
//   final VoidCallback onTap;

//   Widget build(BuildContext context) {
//     return Material(
//       // Slightly opaque color appears where the image has transparency.
//       color: Theme.of(context).primaryColor.withOpacity(0.25),
//       child: InkWell(
//         onTap: onTap,
//         child: Image.asset(
//             photo,
//             fit: BoxFit.contain,
//           )
//       ),
//     );
//   }
// }

// class RadialExpansion extends StatelessWidget {
//   RadialExpansion({
//     Key? key,
//     this.maxRadius,
//     this.child,
//   }) : clipRectSize = 2.0 * (maxRadius! / math.sqrt2),
//        super(key: key);

//   final double? maxRadius;
//   final clipRectSize;
//   final Widget? child;

//   @override
//   Widget build(BuildContext context) {
//     return ClipOval(
//       child: Center(
//         child: SizedBox(
//           width: clipRectSize,
//           height: clipRectSize,
//           child: ClipRect(
//             child: child,  // Photo
//           ),
//         ),
//       ),
//     );
//   }
// }
