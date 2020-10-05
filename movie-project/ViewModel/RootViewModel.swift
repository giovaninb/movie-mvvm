//
//  RootViewModel.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 03/10/20.
//

import Foundation
import UIKit

class RootViewModel {
    
    private var listTopMovies: [Movie]?
    
    var downloadDelegate: DownloadDelegate?
    
    init() {
        fetchTopMovies()
    }

    func fetchTopMovies(){
        DataAccess.getTopMovies { (listMovies) in
            let result = listMovies?.results ?? []
            self.listTopMovies = self.orderByRating(movieList: result)
            
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    func orderByRating(movieList: [Movie]) -> [Movie] {
        return movieList.sorted(by: {$0.voteAverage! > $1.voteAverage!})
    }
    
    public func getCover(byIndexPath index: Int) -> String {
        guard let cover = listTopMovies?[index].posterPath else {return ""}
        return cover
    }
    
    public func getTitle(byIndexPath index: Int) -> String {
        guard let title =  listTopMovies?[index].title else {return ""}
        return title
    }
    
    public func getOverview(byIndexPath index: Int) -> String {
        guard let overview =  listTopMovies?[index].overview else {return ""}
        return overview
    }
    
    public func getPopularity(byIndexPath index: Int) -> String {
        let popularity =  String(format: "%.1f", listTopMovies?[index].voteAverage ?? 100)
        return popularity
    }
    
    public func getTopMoviesCount() -> Int {
        return listTopMovies?.count ?? 0
    }
    
    public func getMovieID(byIndexPath index: Int) -> Int {
        guard let id =  listTopMovies?[index].id else {return 0}
        return id
    }
    
    
    
}

