//
//  DetailView.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 05/10/20.
//

import UIKit

class DetailView: UIViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    var viewModel : DetailViewModel?
    var id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = DetailViewModel(id: self.id!)
        
        cover.layer.cornerRadius = 16
        
        activityIndicator.startAnimating()
        imageActivityIndicator.startAnimating()

        overview.sizeToFit()
//        viewModel?.downloadDelegate = self
        setupMovieDetail()
    }
    
    func setupMovieDetail() {
        guard let viewModel = self.viewModel else {return}
        movieTitle.text = viewModel.getTitle()
        rating.text = viewModel.getPopularity()
        overview.text = viewModel.getOverview()
        genres.text = viewModel.getGenres()
        
        let imagePath = viewModel.getCover()
        
        if imagePath == "" {return}
        
        let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + (imagePath))
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: imageUrl!) else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.cover.image = image
                self.imageActivityIndicator.isHidden = true
            }
        }
        
    }

}

extension DetailView : DownloadDelegate {
    func didFinishDownload() {
                DispatchQueue.main.async {
            self.setupMovieDetail()
            self.activityIndicator.isHidden = true
            self.detailScrollView.isHidden = false
        }
    }
    
    
}
