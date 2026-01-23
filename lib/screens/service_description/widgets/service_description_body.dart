/*
 * Najaz Mobile App
 * Service Description Body Widget
 */

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:najaz_app/utils/app_navigation.dart';
import 'package:najaz_app/utils/application_localization.dart';
import 'package:najaz_app/utils/constants/route_constants.dart';
import 'package:najaz_app/utils/constants/string_constants.dart';
import 'package:najaz_app/utils/shared_preferences/shared_preference_helper.dart';

import '../../../models/service_models/service_form_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_spacing.dart';
import '../../../utils/app_text_styles.dart';
import '../../../widgets/common_widgets.dart';
import '../../../widgets/image_view.dart';

class ServiceDescriptionBody extends StatelessWidget {
  final String? serviceId;
  final ServiceFormModel? serviceForm;
  final String? fallbackName;
  final String? fallbackDescription;
  final String? fallbackImage;

  const ServiceDescriptionBody({
    super.key,
    this.serviceId,
    this.serviceForm,
    this.fallbackName,
    this.fallbackDescription,
    this.fallbackImage,
  });

  @override
  Widget build(BuildContext context) {
    final data = _resolveData();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        // left: AppSpacing.spacingLarge,
        // right: AppSpacing.spacingLarge,
        //  top: AppSpacing.spacingLarge,
        bottom: AppSpacing.spacingMedium,
      ),
      child: Column(
        children: [
          _ServiceImage(urls: data.images),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(
              left: AppSpacing.spacingLarge,
              right: AppSpacing.spacingLarge,
              bottom: AppSpacing.spacingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    StringConstants.serviceDescription.localized(),
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 16),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Html(
                    data: data.description,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(
                          AppTextStyles.bodyMedium.fontSize ?? 14,
                        ),
                        color: AppColors.textSecondary,
                        textAlign: TextAlign.right,
                      ),
                      'p': Style(
                        margin: Margins.only(bottom: 8),
                        textAlign: TextAlign.right,
                      ),
                      'strong': Style(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        textAlign: TextAlign.right,
                      ),
                      'ul': Style(
                        margin: Margins.only(right: 12, bottom: 8),
                        padding: HtmlPaddings.zero,
                      ),
                      'li': Style(
                        margin: Margins.only(bottom: 6),
                        textAlign: TextAlign.right,
                      ),
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Padding(
                //   padding: const EdgeInsets.all(12),
                //   child: Text(
                //     StringConstants.requiredDocuments.localized(),
                //     style: AppTextStyles.bodyLarge.copyWith(
                //       fontWeight: FontWeight.w700,
                //       color: AppColors.textPrimary,
                //     ),
                //     textAlign: TextAlign.end,
                //   ),
                // ),
                const SizedBox(height: 8),
                // ...data.requiredDocuments.map(_DocumentTile.new),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    StringConstants.ensureDocumentsBeforeContinue.localized(),
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(height: 16),
                Builder(
                  builder: (context) {
                    final isVerified = appStoragePref.getAccountVerified();
                    final backgroundColor =
                        isVerified
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.4);
                    final textColor =
                        isVerified
                            ? Colors.white
                            : Colors.white.withOpacity(0.8);

                    return CommonWidgets().appButton(
                      context,
                      StringConstants.startRequest.localized(),
                      () {
                        if (!isVerified) {
                          _showVerificationRequiredDialog(context);
                        } else {
                          // TODO: Start request flow
                        }
                      },
                      backgroundColor: backgroundColor,
                      textColor: textColor,
                    );
                  },
                ),
                SizedBox(height: AppSpacing.getSafeAreaBottom(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _ServiceDescriptionData _mockServiceData() {
    return const _ServiceDescriptionData(
      description:
          'خدمة رقمية تتيح للمواطنين توثيق عقود الزواج رسمياً عبر إدخال بيانات الطرفين ورفع المرفقات ليتم مراجعتها واعتمادها من المختص وحفظها في قاعدة بيانات الوزارة.',
      images: [],
      requiredDocuments: [
        'الهوية الوطنية (الزوج والزوجة)',
        'الهوية الوطنية (ولي الأمر والشهود)',
        'التقارير الطبية',
      ],
    );
  }

  _ServiceDescriptionData _resolveData() {
    final model = serviceForm;
    if (model == null) {
      return _ServiceDescriptionData(
        description: fallbackDescription ?? _mockServiceData().description,
        images: _extractImageUrls(fallbackImage),
        requiredDocuments: _mockServiceData().requiredDocuments,
      );
    }

    final images = _extractServiceImages(model);
    final documents =
        model.form?.groups
            ?.expand((group) => group.fields ?? const <ServiceFormField>[])
            .map((field) => field.label)
            .where((label) => label != null && label.trim().isNotEmpty)
            .cast<String>()
            .toList() ??
        const <String>[];

    return _ServiceDescriptionData(
      description:
          model.description ??
          fallbackDescription ??
          _mockServiceData().description,
      images: images.isNotEmpty ? images : _extractImageUrls(fallbackImage),
      requiredDocuments:
          documents.isNotEmpty
              ? documents
              : _mockServiceData().requiredDocuments,
    );
  }

  List<String> _extractServiceImages(ServiceFormModel model) {
    final images =
        model.images
            ?.map((image) => image.url ?? image.path)
            .whereType<String>()
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList() ??
        [];
    if (images.isNotEmpty) {
      return images;
    }
    return _extractImageUrls(model.baseImage);
  }

  List<String> _extractImageUrls(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return [];
    }
    final normalized = raw.replaceAll(';', ',').replaceAll('|', ',');
    return normalized
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();
  }

  void _showVerificationRequiredDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            StringConstants.verifyAccountToAccessServices.localized(),
            textAlign: TextAlign.end,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          actions: [
            CommonWidgets().appButton(
              context,
              StringConstants.goToVerification.localized(),
              () {
                Navigator.of(context).pop();
                AppNavigation.navigateTo(
                  context,
                  RouteConstants.accountVerification,
                );
              },
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
            ),
          ],
        );
      },
    );
  }
}

class _ServiceImage extends StatefulWidget {
  const _ServiceImage({required this.urls});

  final List<String> urls;

  @override
  State<_ServiceImage> createState() => _ServiceImageState();
}

class _ServiceImageState extends State<_ServiceImage> {
  late final PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urls = widget.urls;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 2 / 2,
            child:
                urls.isEmpty
                    ? Container(
                      color: AppColors.surfaceLight,
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                    : PageView.builder(
                      controller: _controller,
                      itemCount: urls.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return ImageView(url: urls[index], fit: BoxFit.cover);
                      },
                    ),
          ),
        ),
        if (urls.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(urls.length, (index) {
              final isActive = index == _currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color:
                      isActive
                          ? AppColors.primaryColor
                          : AppColors.textSecondary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

// class _DocumentTile extends StatelessWidget {
//   const _DocumentTile(this.title);
//
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 28,
//             height: 28,
//             decoration: BoxDecoration(
//               color: AppColors.surfaceLight,
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(color: const Color(0xFFF0E9DB)),
//             ),
//             child: const Icon(
//               Icons.insert_drive_file_outlined,
//               size: 16,
//               color: AppColors.primaryColor,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               title,
//               style: AppTextStyles.bodyMedium.copyWith(
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _ServiceDescriptionData {
  final String description;
  final List<String> images;
  final List<String> requiredDocuments;

  const _ServiceDescriptionData({
    required this.description,
    required this.images,
    required this.requiredDocuments,
  });
}
