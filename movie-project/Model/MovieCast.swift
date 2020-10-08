//
//  MovieCast.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation

struct MovieCast: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable {
    let name: String
    let character: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case character
        case profilePath = "profile_path"
    }
}




