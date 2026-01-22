/*
 * Najaz Mobile App
 * Static Home Data
 * 
 * This file contains static/hardcoded data for the home screen.
 * Used when there are no GraphQL queries available.
 */

import '../../../models/home_models/home_data_model.dart';
import '../../../models/service_models/category_model.dart';
import '../../../models/service_models/service_model.dart';

/// Static Home Data
///
/// Provides hardcoded data for home screen display
class StaticHomeData {
  /// Get static categories list
  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
        id: '1',
        name: 'Category 1',
        slug: 'category-1',
        description: 'First category',
        imageUrl: null,
        bannerUrl: null,
      ),
      CategoryModel(
        id: '2',
        name: 'Category 2',
        slug: 'category-2',
        description: 'Second category',
        imageUrl: null,
        bannerUrl: null,
      ),
      CategoryModel(
        id: '3',
        name: 'Category 3',
        slug: 'category-3',
        description: 'Third category',
        imageUrl: null,
        bannerUrl: null,
      ),
      CategoryModel(
        id: '4',
        name: 'Category 4',
        slug: 'category-4',
        description: 'Fourth category',
        imageUrl: null,
        bannerUrl: null,
      ),
      CategoryModel(
        id: '5',
        name: 'Category 5',
        slug: 'category-5',
        description: 'Fifth category',
        imageUrl: null,
        bannerUrl: null,
      ),
    ];
  }

  /// Get static services list (optional, for preview)
  static List<ServiceModel> getServices() {
    return [
      ServiceModel(
        id: '1',
        name: 'Service 1',
        description: 'Description for service 1',
        baseImage: null,
        category: ServiceCategory(
          id: '1',
          name: 'Category 1',
        ),
      ),
      ServiceModel(
        id: '2',
        name: 'Service 2',
        description: 'Description for service 2',
        baseImage: null,
        category: ServiceCategory(
          id: '2',
          name: 'Category 2',
        ),
      ),
      ServiceModel(
        id: '3',
        name: 'Service 3',
        description: 'Description for service 3',
        baseImage: null,
        category: ServiceCategory(
          id: '3',
          name: 'Category 3',
        ),
      ),
    ];
  }

  /// Get static banners (optional)
  static List<BannerModel> getBanners() {
    return [
      // Add banners if needed
      // BannerModel(
      //   id: '1',
      //   imageUrl: 'https://example.com/banner1.jpg',
      //   title: 'Banner 1',
      //   link: null,
      // ),
    ];
  }

  /// Get static home data model
  static HomeDataModel getHomeData() {
    return HomeDataModel(
      banners: getBanners(),
      categories: getCategories(),
      success: true,
      status: true,
    );
  }
}
