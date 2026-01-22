/*
 * Najaz Mobile App
 * History Status Overlay
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HistoryStatusOverlay extends StatelessWidget {
  final String assetPath;
  final VoidCallback onClose;
  final VoidCallback onPrimary;
  final VoidCallback? onSecondary;
  final bool showSecondaryButton;

  const HistoryStatusOverlay({
    super.key,
    required this.assetPath,
    required this.onClose,
    required this.onPrimary,
    this.onSecondary,
    required this.showSecondaryButton,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;
    final scale = width / 380;
    final height = 424 * scale;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  assetPath,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 324 * scale,
                top: 32 * scale,
                width: 24 * scale,
                height: 24 * scale,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onClose,
                ),
              ),
              if (showSecondaryButton)
                Positioned(
                  left: 33 * scale,
                  top: 345 * scale,
                  width: 148 * scale,
                  height: 46 * scale,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onSecondary,
                  ),
                )
              else
                Positioned(
                  left: 32 * scale,
                  top: 344 * scale,
                  width: 316 * scale,
                  height: 48 * scale,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onPrimary,
                  ),
                ),
              if (showSecondaryButton)
                Positioned(
                  left: 198 * scale,
                  top: 344 * scale,
                  width: 150 * scale,
                  height: 48 * scale,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onPrimary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

