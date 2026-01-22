/*
 * Najaz Mobile App
 * Services Page GraphQL Query
 * 
 * This file contains the GraphQL query for services page data.
 */

class ServicesPageQuery {
  static const String servicesPage = '''
    query servicesPage(
      \$search: String
      \$categoryId: Int
      \$page: Int
      \$limit: Int
    ) {
      servicesPage(
        search: \$search
        categoryId: \$categoryId
        page: \$page
        limit: \$limit
      ) {
        categories {
          id
          name
          description
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
            image
          }
        }
        services {
          data {
            id
            name
            baseImage
            image
            status
          }
          paginatorInfo {
            total
          }
        }
      }
    }
  ''';
}
