/*
 * Najaz Mobile App
 * Service Categories GraphQL Query
 * 
 * This file contains the GraphQL query for fetching service categories with their services.
 */

class ServiceCategoriesQuery {
  static const String serviceCategories = '''
    query serviceCategories(
      \$page: Int
      \$limit: Int
      \$parentId: Int
    ) {
      serviceCategories(
        page: \$page
        limit: \$limit
        parentId: \$parentId
      ) {
        data {
          id
          name
          slug
          status
          position
          parentId
          logoUrl
          bannerUrl
          url
          services {
            id
            name
            baseImage
          }
        }
        paginatorInfo {
          count
          currentPage
          lastPage
          total
          hasMorePages
        }
      }
    }
  ''';
}

