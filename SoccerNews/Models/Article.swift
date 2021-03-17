//
//  Article.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/17.
//

import Foundation

struct Article: Codable {
    let source: Source?
    let author: String?
    let content: String?
    let description: String?
    let publishedAt: String?
    let title: String?
    let url: String?
    let urlToImage: String?
}
