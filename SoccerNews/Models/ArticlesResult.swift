//
//  ArticlesResult.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/17.
//

import Foundation

struct ArticlesResult: Codable {
    let status:  Statuses
    let totalResults: Int
    let articles: [Article]
}
