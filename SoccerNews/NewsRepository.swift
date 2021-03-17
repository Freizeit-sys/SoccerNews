//
//  NewsRepository.swift
//  SoccerNews
//
//  Created by Admin on 2021/03/16.
//

import Foundation

class NewsRepository: NSObject {
    
    private static var singleton = NewsRepository()
    
    static var shared: NewsRepository {
        return singleton
    }
    
    private let base_url = "https://newsapi.org/v2/"
    private let apiKey = "d3f995173287458182e3bb46bdeed061"
    
    func fetchArticle(completion: @escaping([Article]) -> Void) {
        let url = URL(string: "https://newsapi.org/v2/everything?q=Soccer&language=jp&sortBy=publishedAt&pageSize=5&apiKey=\(apiKey)")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let jsonData = data else { return print("Failed to fetch json data.") }
            do {
                let articlesResult = try JSONDecoder().decode(ArticlesResult.self, from: jsonData)
                let articles = articlesResult.articles
                completion(articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    public func fetchTopHeadlines(_ request: TopHeadlinesRequest, completion: @escaping([Article]) -> Void) {
        // build the querystring
        var queryParams: [String] = []
        // q
        let q = request.q.trimmingCharacters(in: .whitespacesAndNewlines)
        queryParams.append("q=" + q)
        // sources
        if request.sources.count > 0 {
            queryParams.append("sources=" + request.sources.joined(separator: ","))
        }
        // categories
        if let category = request.category?.rawValue {
            queryParams.append("category=" + category.lowercased())
        }
        // language
        if let language = request.language?.rawValue {
            queryParams.append("language=" + language.lowercased())
        }
        // country
        if let country = request.country?.rawValue {
            queryParams.append("country=" + country)
        }
        // page
        if request.page > 1 {
            queryParams.append("page=" + "\(request.page)")
        }
        // pageSize
        if request.pageSize > 0 {
            queryParams.append("pageSize=" + "\(request.pageSize)")
        }
        // join them together
        let queryString = queryParams.joined(separator: "&")
        
        makeRequest("top-headlines", queryString) { (articlesResult) in
            completion(articlesResult.articles)
        }
    }
    
    public func fetchEverything(_ request: EverythingRequest, completion: @escaping([Article]) -> Void) {
        // build the querystring
        var queryParams: [String] = []
        // q
        let q = request.q.trimmingCharacters(in: .whitespacesAndNewlines)
        queryParams.append("q=" + q)
        // sources
        if request.sources.count > 0 {
            queryParams.append("sources=" + request.sources.joined(separator: ","))
        }
        // domains
        if request.domains.count > 0 {
            queryParams.append("domains=" + request.domains.joined(separator: ","))
        }
        // from
        if let from = request.from {
            queryParams.append("from=" + from.string(format: "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"))
        }
        // to
        if let to = request.to {
            queryParams.append("to=" + to.string(format: "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"))
        }
        // language
        if let language = request.language?.rawValue {
            queryParams.append("language=" + language.lowercased())
        }
        // sortBy
        if let sortBy = request.sortBy?.rawValue {
            queryParams.append("sortBy=" + sortBy)
        }
        // page
        if request.page > 1 {
            queryParams.append("page=" + "\(request.page)")
        }
        // pageSize
        if request.pageSize > 0 {
            queryParams.append("pageSize=" + "\(request.pageSize)")
        }
        // join them together
        let queryString = queryParams.joined(separator: "&")
        
        makeRequest("everything", queryString) { (articlesResult) in
            completion(articlesResult.articles)
        }
    }
    
    func makeRequest(_ endpoint: String, _ queryString: String, completion: @escaping(ArticlesResult) -> Void) {
        let url = URL(string: base_url + endpoint + "?" + queryString + "&apiKey=\(apiKey)")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let jsonData = data else { return print("Failed to fetch json data.") }
            do {
                let articleResults = try JSONDecoder().decode(ArticlesResult.self, from: jsonData)
                completion(articleResults)
            } catch {
                print("Failed to decode json:", error.localizedDescription)
            }
        }
        task.resume()
    }
}
