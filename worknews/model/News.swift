//
//  News.swift
//  worknews
//
//  Created by Rajan Desai on 06/08/22.
//

//
//  News.swift
//  newsDemo
//
//  Created by Rajan Desai on 06/08/22.
//

import Foundation
struct NewsData: Decodable {
    let news: [News]
    
    private enum CodingKeys: String, CodingKey {
        case news = "articles"
    }
}

struct News: Decodable {
    let titles: String?
    let date: String?
    let name: String?
    let Image: String?
  //  let backdropImage: String?
    let overView: String?
    let details: String?
    
    private enum CodingKeys: String, CodingKey {
        case titles = "title"
        case date = "publishedAt"
        case name = "author"
        case Image = "urlToImage"
        case overView = "description"
        case details = "content"
      //  case backdropImage = ""
    }
}

