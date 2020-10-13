//
//  BackdropsListView.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation

class BackdropsListViewModel {

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
    
    func listBackdrops(movieListImages: [Backdrop]) -> [Backdrop] {
        return movieListImages
    }
    
    public func getBackdrops(byIndexPath index: Int) -> String {
        guard let backdropsFilePath = movieImages?.backdrops[index].filePath else {return ""}
        return backdropsFilePath
    }
    
    public func getIdMovie() -> String {
        let idMovie = String(movieImages?.id ?? 724089)
        return idMovie
    }
    
    public func getBackDropsCount() -> Int {
        movieImages?.backdrops.count ?? 0
    }
    
}
