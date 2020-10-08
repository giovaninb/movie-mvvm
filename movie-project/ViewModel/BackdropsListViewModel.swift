//
//  BackdropsListView.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import Foundation


class BackdropsListViewModel {
    
    private var movieListImage: MovieImages?
    private var currentPage : Int = 1
    var downloadDelegate: DownloadDelegate?
    
    
    init(id: Int) {
        fetchMovieImages(withId: id)
    }
    
//    func fetchMovieImages(for id: Int) {
//        let currentIndex = indexPath.row + 1
//
//        if currentIndex/20 == currentPage {
//            currentPage += 1
//            fetchMovieImages()
//        }
//    }
//
    func fetchMovieImages(withId id: Int){
        DataAccess.getMovieImages(from: id) { (movieImages) in
            guard let backdrops = movieImages else {return}
            self.movieListImage = backdrops
            self.downloadDelegate?.didFinishDownload()
        
        }
    }
    
    public func getBackdrops(byIndex index: Int) -> String {
        guard let backdrops =  movieListImage?.backdrops?[index] else {return ""}
        let pathBack = backdrops.filePath
        print(pathBack)
        return pathBack
    }
    
    
}
