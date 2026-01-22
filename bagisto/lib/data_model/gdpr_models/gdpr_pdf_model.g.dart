// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gdpr_pdf_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GdprPdfModel _$GdprPdfModelFromJson(Map<String, dynamic> json) => GdprPdfModel(
      success: json['success'] as bool?,
      string: json['string'] as String?,
      download: json['download'] == null
          ? null
          : DownloadPdf.fromJson(json['download'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GdprPdfModelToJson(GdprPdfModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'string': instance.string,
      'download': instance.download,
    };

DownloadPdf _$DownloadPdfFromJson(Map<String, dynamic> json) => DownloadPdf(
      fileName: json['fileName'] as String?,
      extension: json['extension'] as String?,
    );

Map<String, dynamic> _$DownloadPdfToJson(DownloadPdf instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'extension': instance.extension,
    };
