//
//  MovieImages.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation

struct MovieImages: Codable {
    var backdrops: [Backdrops]?
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id, backdrops
    }
}

struct Backdrops: Codable {
    let aspectRatio: Double
    let filePath: String
    let height, width: Int
}

enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case width
    }
