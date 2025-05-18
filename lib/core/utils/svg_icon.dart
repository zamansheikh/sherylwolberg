import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Utility widget to render SVG assets with customizable options.
///
/// Example usage:
///   SvgIcon(
///     assetName: AppAssets.iconHome,
///     width: 24,
///     height: 24,
///     color: Colors.blue, // Optional: override SVG color
///   )
class SvgIcon extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final String? semanticsLabel;

  const SvgIcon({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticsLabel,
    );
  }
}
