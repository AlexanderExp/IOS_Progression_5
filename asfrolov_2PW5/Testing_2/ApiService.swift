//
//  ApiService.swift
//  Testing_2
//
//  Created by admin on 30.11.2022.
//

import Foundation
import UIKit
import Combine

public final class ApiService {
    static let shared = ApiService()
    
    public static let urlTopArticles = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=fe4521d4d36f4aea90defb4024c93bcd")
    
    public init() {}
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = ApiService.urlTopArticles else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _,error in
        if let error = error {
            completion(.failure(error))
        } else if let data = data {
            do {
                let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                // print("Articles: \(result.articles.count)")
                completion(.success(result.articles))
            }
            catch {
                completion(.failure(error))
            }
        }
    }
    task.resume()
}
}

public struct ApiResponse: Codable {
    let articles: [Article]
}
public struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
    var imageData: Data? = nil
}

struct Source: Codable {
    let name: String?
}
