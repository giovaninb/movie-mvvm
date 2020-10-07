//
//  Movie.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 30/09/20.
//

import Foundation

struct ListMovie: Codable {
    let results: [Movie]?
    let page, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults
    }
}

struct Movie: Codable {
    let voteCount, id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let overview, releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
