//
//  DataAccess.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 30/09/20.
//

import Foundation

struct DataAccess {
    
    
    static let apiKey: String = "16fd5a2a34d2c3651edf338a920f6176"
    
    static func getPopularMovies(fromPage page: Int = 1, completionHandler completion: @escaping (ListMovie?) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=pt-BR&page=\(page)")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let listMovie = try? JSONDecoder().decode(ListMovie.self, from: data!)
                    completion(listMovie)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
   
    static func getNowPlayingMovies(fromPage page: Int = 1, completionHandler completion: @escaping (ListMovie?) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/  ?api_key=\(apiKey)&language=pt-BR&page=\(page)")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let listMovie = try? JSONDecoder().decode(ListMovie.self, from: data!)
                    completion(listMovie)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
    
    static func getDetailsMovie(fromId id: Int, completionHandler completion: @escaping (MovieDetail?) -> Void) {
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=pt-BR")!)

        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data!)
                    completion(movieDetail)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
    
    static func getMovies(named name: String, completionHandler completion: @escaping (ListMovie?) -> Void) {
        
        let urlName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=pt-BR&query=\(urlName)&page=1&include_adult=false")!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            guard let error = error
                else {
                    let listMovie = try? JSONDecoder().decode(ListMovie.self, from: data!)
                    completion(listMovie)
                    return
            }
            print(error.localizedDescription)
            completion(nil)
            return
        })
        dataTask.resume()
    }
    
}