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
    
    func listCasts(movieListCasts: [Cast]) -> [Cast] {
        return movieListCasts
    }
    
    public func getCastName(byIndexPath index: Int) -> String {
        guard let castName = movieCast?.cast[index].name else {return ""}
        return castName
    }
    
    public func getCastCharacter(byIndexPath index: Int) -> String {
        guard let castCharacter = movieCast?.cast[index].character else {return ""}
        return castCharacter
    }
    
    public func getCastCount() -> Int {
        movieCast?.cast.count ?? 0
    }
    
    public func getCastPhoto(byIndexPath index: Int) -> String {
        guard let castProfilePath = movieCast?.cast[index].profilePath else {return ""}
        return castProfilePath
    }

    
}
