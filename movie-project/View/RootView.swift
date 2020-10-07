//
//  RootView.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 02/10/20.
//

import UIKit

class RootView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: RootViewModel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        tableView.isHidden = true
        
        viewModel = RootViewModel()
        viewModel?.downloadDelegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else {return 1}
        return viewModel.getTopMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        view.backgroundColor = #colorLiteral(red: 0.05294474214, green: 0.1764830947, blue: 0.1771250665, alpha: 1)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListaFilmes") as? TopMoviesViewCell else {return UITableViewCell()}
        
        let moviewIndex = indexPath.row
        
        guard let viewModel = self.viewModel else {return cell}
        cell.movieTitle.text = viewModel.getTitle(byIndexPath: moviewIndex)
        cell.overview.text = viewModel.getOverview(byIndexPath: moviewIndex)
        cell.rating.text = viewModel.getPopularity(byIndexPath: moviewIndex)
        cell.year.text = viewModel.getYear(byIndexPath: moviewIndex)
        
        let imagePath = viewModel.getCover(byIndexPath: moviewIndex)
        
        if imagePath == "" {return cell}
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (imagePath))
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: imageUrl!) else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                cell.cover.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        let movieID = viewModel.getMovieID(byIndexPath: indexPath.row)
        performSegue(withIdentifier: "detail", sender: movieID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movieId = sender as? Int {
            if let movieDetailView = segue.destination as? DetailView {
                movieDetailView.id = movieId
            }
        }
    }

}

extension RootView: DetailMovieSegue {
    func didNavigateDetail(movieId: Int) {
        performSegue(withIdentifier: "detail", sender: movieId)
    }
}

protocol DownloadDelegate {
    func didFinishDownload()
}

protocol DetailMovieSegue {
    func didNavigateDetail(movieId: Int)
}

extension RootView: DownloadDelegate {
    func didFinishDownload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.activityIndicator.isHidden = true
        }
    }
}

