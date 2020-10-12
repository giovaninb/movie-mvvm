//
//  BackdropsListView.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation


class BackdropsListViewModel {

    private var listBackdrops: [Backdrops]?
    private var movieImages: MovieImages?
    var downloadDelegate: DownloadDelegate?
    
    
    init(id: Int) {
        fetchMovieImages(withId: id)
    }
    
    func fetchMovieImages(withId id: Int){
        DataAccess.getMovieImages(from: id) { (movieImages) in
            guard let movieImages = movieImages else {return}
            self.movieImages = movieImages
            self.downloadDelegate?.didFinishDownload()
        
        }
    }
    
    func listBackdrops(movieListImages: [Backdrops]) -> [Backdrops] {
        return movieListImages
    }
    
    public func getBackdrops() -> String {
        guard let backdrops = movieImages?.backdrops else {return ""}
        let backdropsString = backdrops.map { (backdrops) -> String in
            return backdrops.filePath
        }.joined()
        return backdropsString
    }
    
}
