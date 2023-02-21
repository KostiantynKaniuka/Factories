//
//  Article.swift
//  GoodNews
//
//  Created by Kostiantyn Kaniuka on 21.02.2023.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
