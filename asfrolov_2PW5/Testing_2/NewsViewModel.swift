//
//  NewsViewModel.swift
//  Testing_2
//
//  Created by admin on 30.11.2022.
//

import Foundation
import UIKit

final class NewsViewModel: Decodable, Encodable {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, description: String, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
    
}
