//
//  DetailViewModel.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 03/10/20.
//

import Foundation

class DetailViewModel {
    
    private var movieDetail: MovieDetail?
    var downloadDelegate: DownloadDelegate?
    
    
    init(id: Int) {
        fetchMovieDetail(withId: id)
    }
    
    func fetchMovieDetail(withId id: Int){
        DataAccess.getDetailsMovie(fromId: id) { (movieDetail) in
            guard let movieDetail = movieDetail else {return}
            self.movieDetail = movieDetail
            self.downloadDelegate?.didFinishDownload()
        }
    }
    
    public func getBackground() -> String {
        guard let background =  movieDetail?.backdropPath else {return ""}
        return background
    }
    
    public func getCover() -> String {
        guard let cover =  movieDetail?.posterPath else {return ""}
        return cover
    }
    
    public func getTitle() -> String {
        guard let title =  movieDetail?.title else {return ""}
        return title
    }
    
    public func getOverview() -> String {
        guard let overview =  movieDetail?.overview else {return ""}
        return overview
    }
    
    public func getRuntime() -> String {
        guard let runtimeMin =  movieDetail?.runtime else {return ""}
        let runtimeSec = runtimeMin * 60
        let runtime = runtimeSec.asString(style: .abbreviated)
        return runtime
    }
    
    public func getGenres() -> String {
        guard let genres =  movieDetail?.genres else {return ""}
        let genresString = genres.map { (genre) -> String in
            return genre.name ?? ""
            }.joined(separator: ", ")
        return genresString
    }
    
    
    public func getPopularity() -> String {
        let popularity =  String(format: "%.1f", movieDetail?.voteAverage ?? 100)
        return popularity
    }
}

extension Double {
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute]
    formatter.unitsStyle = style
    guard let formattedString = formatter.string(from: self) else { return "" }
    return formattedString
  }
}
