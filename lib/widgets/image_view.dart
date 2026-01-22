/*
 * Najaz Mobile App
 * Image View Widget
 * 
 * This file contains a reusable image widget for displaying network images
 * with caching, placeholder, and error handling.
 * Follows Bagisto's ImageView pattern, tailored for Najaz.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Image View Widget
/// 
/// A reusable widget for displaying network images with:
/// - Caching (using CachedNetworkImage)
/// - Placeholder support
/// - Error handling with fallback image
/// - Customizable size and fit
/// 
/// Example:
/// ```dart
/// ImageView(
///   url: "https://example.com/image.jpg",
///   width: 200,
///   height: 200,
///   fit: BoxFit.cover,
/// )
/// ```
class ImageView extends StatelessWidget {
  /// Image URL to display
  final String? url;

  /// Image height (optional, if 0.0 then height is not constrained)
  final double height;

  /// Image width (optional, if 0.0 then width is not constrained)
  final double width;

  /// How the image should be fitted within its bounds
  final BoxFit? fit;

  /// Placeholder image asset path (optional, defaults to AssetConstants.placeHolder)
  final String? placeHolder;

  const ImageView({
    Key? key,
    this.url,
    this.width = 0.0,
    this.height = 0.0,
    this.placeHolder,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  /// Builds placeholder widget
  Widget _buildPlaceholder() {
    return Container(
      width: width != 0.0 ? width : null,
      height: height != 0.0 ? height : null,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        Icons.image_outlined,
        size: (width != 0.0 && height != 0.0) 
            ? (width < height ? width * 0.4 : height * 0.4) 
            : 40.0,
        color: Colors.grey[600],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return _buildPlaceholder();
    }

    return CachedNetworkImage(
      width: width != 0.0 ? width : null,
      height: height != 0.0 ? height : null,
      fit: fit ?? BoxFit.scaleDown,
      imageUrl: url!,
      placeholder: (context, url) => _buildPlaceholder(),
      errorWidget: (context, url, error) => _buildPlaceholder(),
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
    );
  }
}

