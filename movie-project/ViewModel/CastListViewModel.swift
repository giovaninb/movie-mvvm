//
//  CastListViewModel.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation

class CastListViewModel {
    
    private var movieCast: MovieCast?
    var downloadDelegate: DownloadDelegate?
    
    init(id: Int) {
        fetchMovieCast(withId: id)
    }
    
    func fetchMovieCast(withId id: Int){
        DataAccess.getCasts(fromId: id) { (movieCast) in
            guard let movieCast = movieCast else {return}
            self.movieCast = movieCast
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    public func getCastName() -> String {
        guard let casts = movieCast?.cast else {return ""}
        let castString = casts.map { (cast) -> String in
            return cast.name
            }.joined(separator: ", ")
        return castString
    }
    
    public func getCastCharacter() -> String {
        guard let casts = movieCast?.cast else {return ""}
        let castString = casts.map { (cast) -> String in
            return cast.name
            }.joined(separator: ", ")
        return castString
    }
    
//    public func getCastName() -> String {
//        guard let casts = movieCast?.cast else {return ""}
//        let castString = casts.map { (cast) -> String in
//            return cast.name
//            }.joined(separator: ", ")
//        return castString
//    }
    
}
