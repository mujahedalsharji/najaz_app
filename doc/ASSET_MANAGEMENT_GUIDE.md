# Asset Management Guide - Najaz App

## Overview

This guide explains when and how to handle different types of assets in the Najaz app, following Bagisto's patterns.

---

## 📦 Types of Assets

### 1. **Static Assets** (Bundled with App)
**Location**: `assets/` folder  
**When to Use**: 
- App logo, icons, splash screen assets
- Placeholder images
- Lottie animations (splash, empty states, loading)
- Fonts
- Language JSON files

**How to Add**:
```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/images/
    - assets/lottie/
    - assets/fonts/
    - assets/language/
```

**How to Use**:
```dart
// Images
Image.asset(AssetConstants.placeHolder)

// Lottie
LottieBuilder.asset(AssetConstants.splashLottie)

// Language files (handled by ApplicationLocalizations)
StringConstants.welcome.localized()
```

---

### 2. **Dynamic Assets from API** (Network Images)
**Source**: GraphQL API responses (URLs)  
**When to Use**:
- Service images
- User profile pictures
- Booking/service thumbnails
- Category images
- Any content images that come from backend

**How It Works**:
- API returns image URLs (e.g., `"https://najaz.rawnaqq.com/storage/services/image.jpg"`)
- URLs are displayed using `ImageView` widget
- `CachedNetworkImage` automatically:
  - Downloads image on first view
  - Caches it locally
  - Reuses cached version for faster loading
  - Shows placeholder while loading
  - Shows error widget if download fails

**How to Use**:
```dart
// In your service model
@JsonSerializable()
class Service {
  String? id;
  String? name;
  String? imageUrl;  // URL from API
  
  Service({this.id, this.name, this.imageUrl});
}

// In your UI
ImageView(
  url: service.imageUrl,  // Direct URL from API
  width: 200,
  height: 200,
  fit: BoxFit.cover,
)
```

**Current Implementation** (`lib/widgets/image_view.dart`):
```dart
CachedNetworkImage(
  imageUrl: url ?? "",
  placeholder: (context, url) => Image.asset(AssetConstants.placeHolder),
  errorWidget: (context, url, error) => Image.asset(AssetConstants.placeHolder),
)
```

✅ **Already implemented** - Just use `ImageView` widget with API URLs!

---

### 3. **File Downloads** (Documents, PDFs, etc.)
**Source**: API provides download URLs  
**When to Use**:
- Invoices/receipts (PDF)
- Service documents
- Any files user needs to download and save locally

**How to Add** (When needed in future phases):

#### Step 1: Add Required Packages
```yaml
# pubspec.yaml
dependencies:
  dio: ^5.0.0  # For file downloads
  path_provider: ^2.1.0  # For file system paths
  permission_handler: ^11.0.0  # For storage permissions
```

#### Step 2: Create Download Service
```dart
// lib/services/file_download_service.dart
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloadService {
  final Dio _dio = Dio();

  Future<String?> downloadFile({
    required String url,
    required String fileName,
    Function(int received, int total)? onProgress,
  }) async {
    try {
      // Request storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          throw Exception('Storage permission denied');
        }
      }

      // Get download directory
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Download file
      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
      );

      return filePath;
    } catch (e) {
      print('Download error: $e');
      return null;
    }
  }
}
```

#### Step 3: Use in UI
```dart
final downloadService = FileDownloadService();

// Download invoice
final filePath = await downloadService.downloadFile(
  url: invoice.downloadUrl,
  fileName: 'invoice_${invoice.id}.pdf',
  onProgress: (received, total) {
    final progress = (received / total) * 100;
    print('Download progress: $progress%');
  },
);

if (filePath != null) {
  ShowMessage.successNotification('File downloaded to $filePath', context);
}
```

---

## 🎯 Strategy for Najaz App

### Current Status (Phase 2)

✅ **Already Ready**:
- Static assets system (images, Lottie, fonts)
- Network image display with caching (`ImageView` widget)
- Placeholder handling

### When to Add Files

| Asset Type | When to Add | Priority |
|------------|-------------|----------|
| **Static Assets** | Add as you create UI screens | High |
| - Splash Lottie | Now (Phase 2.1) | High |
| - Placeholder images | Now | High |
| - App logo | When design provided | Medium |
| - Empty state Lotties | Phase 3 (when implementing empty states) | Medium |
| **API Images** | Use `ImageView` widget with API URLs | Already Ready |
| - Service images | Phase 3 (Service screens) | - |
| - User avatars | Phase 2 (Profile) or Phase 3 | - |
| **File Downloads** | Phase 3+ (when implementing bookings/invoices) | Low |

---

## 📝 Best Practices

### 1. **Static Assets**
- ✅ Keep organized in `assets/` subfolders
- ✅ Use constants in `AssetConstants` class
- ✅ Always provide fallbacks for missing assets
- ✅ Optimize images before adding (compress, resize)

### 2. **API Images**
- ✅ Always use `ImageView` widget (handles caching automatically)
- ✅ Provide placeholder image for loading/error states
- ✅ Handle null/empty URLs gracefully
- ✅ Consider image sizes from API (thumbnail vs full size)

### 3. **File Downloads**
- ✅ Request permissions before downloading
- ✅ Show download progress to user
- ✅ Handle download errors gracefully
- ✅ Store in appropriate directory (documents vs cache)
- ✅ Consider file size limits

---

## 🔧 Implementation Examples

### Example 1: Service Image from API
```dart
// Model (from GraphQL response)
@JsonSerializable()
class Service {
  String? id;
  String? name;
  String? imageUrl;  // "https://najaz.rawnaqq.com/storage/services/123.jpg"
}

// UI Usage
ImageView(
  url: service.imageUrl,
  width: 150,
  height: 150,
  fit: BoxFit.cover,
)
```

### Example 2: User Avatar from API
```dart
// Model
class User {
  String? id;
  String? name;
  String? avatarUrl;
}

// UI Usage
CircleAvatar(
  radius: 30,
  backgroundColor: AppColors.grey100,
  backgroundImage: user.avatarUrl != null
      ? CachedNetworkImageProvider(user.avatarUrl!)
      : null,
  child: user.avatarUrl == null
      ? Text(user.name?[0].toUpperCase() ?? 'U')
      : null,
)
```

### Example 3: Multiple Service Images
```dart
// Service with multiple images
class Service {
  String? id;
  List<String>? imageUrls;
}

// UI - Carousel
CarouselSlider(
  items: service.imageUrls?.map((url) => ImageView(
    url: url,
    width: double.infinity,
    height: 200,
    fit: BoxFit.cover,
  )).toList() ?? [],
  options: CarouselOptions(
    autoPlay: true,
    viewportFraction: 1.0,
  ),
)
```

---

## 🚨 Important Notes

1. **Don't Add API Images to Assets**
   - API images are dynamic and come from backend
   - Just use the URL with `ImageView` widget
   - Caching is handled automatically

2. **Static Assets Must Be in Assets Folder**
   - Lottie files, placeholders, logos must be in `assets/`
   - Update `pubspec.yaml` to include them
   - Run `flutter pub get` after adding

3. **Image URLs from API**
   - Usually absolute URLs: `https://domain.com/path/image.jpg`
   - Sometimes relative: `/storage/image.jpg` (need to prepend base URL)
   - Check API documentation for URL format

4. **Base URL for Relative URLs**
   ```dart
   // If API returns relative URL
   String? imageUrl = service.imageUrl; // "/storage/services/image.jpg"
   
   // Convert to absolute
   if (imageUrl?.startsWith('/') ?? false) {
     imageUrl = '${ServerConfiguration.baseDomain}$imageUrl';
   }
   ```

---

## ✅ Current Checklist

### Static Assets Needed
- [ ] `assets/lottie/splash_screen.json` (Phase 2.1 - Currently using fallback)
- [ ] `assets/images/placeholder.png` (For image placeholders)
- [ ] `assets/images/user_placeholder.png` (For user avatars)
- [ ] `assets/images/service_placeholder.png` (For service images)
- [ ] `assets/images/logo.png` (App logo)
- [ ] `assets/lottie/empty_services.json` (Phase 3)
- [ ] `assets/lottie/empty_bookings.json` (Phase 3)
- [ ] Other empty state Lotties as needed

### API Assets (No Action Needed)
- ✅ `ImageView` widget ready to use
- ✅ Caching handled automatically
- ✅ Just use URLs from API responses

### File Downloads (Future)
- ⏳ Add packages when needed (Phase 3+)
- ⏳ Create download service when implementing downloads

---

## 🎯 Summary

**For Najaz App:**

1. **Static Assets** → Add to `assets/` folder, reference via `AssetConstants`
2. **API Images** → Use `ImageView` widget with URL from API (already implemented!)
3. **File Downloads** → Implement download service when needed (Phase 3+)

**Most common use case**: You'll use `ImageView` widget with URLs from your GraphQL API responses. The widget handles everything automatically! 🎉

