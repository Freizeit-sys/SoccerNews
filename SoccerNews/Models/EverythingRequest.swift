//
//  EverythingRequest.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/17.
//

import Foundation

class EverythingRequest {
    let q: String
    let sources: [String]
    let domains: [String]
    let from: Date?
    let to: Date?
    let language: Languages?
    let sortBy: SortBys?
    let page: Int
    let pageSize: Int
    
    init(q: String, sources: [String], domains: [String], from: Date?, to: Date?, language: Languages?, sortBy: SortBys?, page: Int, pageSize: Int) {
        self.q = q
        self.sources = sources
        self.domains = domains
        self.from = from
        self.to = to
        self.language = language
        self.sortBy = sortBy
        self.page = page
        self.pageSize = pageSize
    }
}
