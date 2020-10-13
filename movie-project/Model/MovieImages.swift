//
//  MovieImages.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation

struct MovieImages: Codable {
    let id: Int
    let backdrops, posters: [Backdrop]
}

struct Backdrop: Codable {
    let aspectRatio: Double
    let filePath: String
    let height: Int
    let iso639_1: String?
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso639_1 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
