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
    let crew: [Crew]
}

struct Cast: Codable {
    let castID: Int
    let character, creditID: String
    let gender, id: Int
    let name: String
    let order: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

struct Crew: Codable {
    let creditID, department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
}


