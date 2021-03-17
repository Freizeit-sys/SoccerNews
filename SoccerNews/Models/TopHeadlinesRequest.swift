//
//  TopHeadlinesRequest.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/17.
//

import Foundation

class TopHeadlinesRequest {
    let q: String
    let sources: [String]
    let category: Categories?
    let language: Languages?
    let country: Countries?
    let page: Int
    let pageSize: Int
    
    init(q: String, sources: [String], category: Categories?, language: Languages?, country: Countries?, page: Int, pageSize: Int) {
        self.q = q
        self.sources = sources
        self.category = category
        self.language = language
        self.country = country
        self.page = page
        self.pageSize = pageSize
    }
}
