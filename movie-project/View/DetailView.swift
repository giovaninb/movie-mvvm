//
//  DetailView.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 05/10/20.
//

import UIKit

class DetailView: UIViewController {
    
//    @IBOutlet var activityIndicator: UIActivityIndicatorView!
//    @IBOutlet var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    @IBOutlet weak var collectionImages: UICollectionView!
    @IBOutlet weak var collectionCasts: UICollectionView!
    
    
    var detailViewModel: DetailViewModel?
    var backdropViewModel: BackdropsListViewModel?
    var castViewModel: CastListViewModel?
    
    var id : Int?
    var imageBackdropsList: MovieImages?
    let imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewModel = DetailViewModel(id: self.id!)
        self.backdropViewModel = BackdropsListViewModel(id: self.id!)
        
        collectionImages.delegate = self
        collectionImages.dataSource = self
        
        collectionCasts.delegate = self
        collectionCasts.dataSource = self
        
        self.rating.layer.cornerRadius = (rating?.frame.size.height)!/4.0
        self.rating?.layer.masksToBounds = true
        self.cover.layer.cornerRadius = 26
        self.cover.layer.borderWidth = 2
        self.cover.layer.borderColor = #colorLiteral(red: 0.3833134472, green: 0.8329965472, blue: 0.46416682, alpha: 1)
//        activityIndicator.startAnimating()
//        imageActivityIndicator.startAnimating()
        overview.sizeToFit()
        detailViewModel?.downloadDelegate = self
        setupMovieDetail()
    }
    
    func setupMovieDetail() {
        guard let viewModel = self.detailViewModel else {return}
        movieTitle.text = viewModel.getTitle()
        rating.text = viewModel.getPopularity()
        overview.text = viewModel.getOverview()
        duration.text = "Duração: " + viewModel.getRuntime()
        
        // Load Images
        loadTopImages()
//        loadBackdropsImages()
        
        
        
    }
    
    func loadTopImages() {
        guard let viewModel = self.detailViewModel else {return}
        let imagePathCover = viewModel.getCover()
        let imagePathBackground = viewModel.getBackground()
        if imagePathCover == "" {return}
        if imagePathBackground == "" {return}
        
        let imageUrlCover = URL(string: imageBaseUrl + (imagePathCover))
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: imageUrlCover!) else {return}
            DispatchQueue.main.async {
                let imageCov = UIImage(data: data)
                self.cover.image = imageCov
//                self.imageActivityIndicator.isHidden = true
            }
        }
        
        let imageUrlBackground = URL(string: imageBaseUrl + (imagePathBackground))
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: imageUrlBackground!) else {return}
            DispatchQueue.main.async {
                let imageBack = UIImage(data: data)
                self.background.image = imageBack
            }
        }
    }

}


extension DetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionImages {
            return 5
        } else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionImages {
            backdropViewModel?.fetchMovieImages(withId: id!)
            print("\(indexPath.row) - \(indexPath.section)")
        } else {
            castViewModel?.fetchMovieCast(withId: id!)
            print("\(indexPath.row) - \(indexPath.section)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionImages {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieImagesCollectionViewCell", for: indexPath) as? BackdropsCollectionViewCell else {return UICollectionViewCell()}
            
            guard let vmB = self.backdropViewModel else {return cell}
            let imagePathBackdrops = vmB.getBackdrops(byIndex: indexPath.row)
            
            if imagePathBackdrops == "" {return cell}
            
            let imageUrlBackdrops = URL(string: imageBaseUrl + (imagePathBackdrops))
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: imageUrlBackdrops!) else {return}
                DispatchQueue.main.async {
                    let imageDrops = UIImage(data: data)
                    cell.backdrops.image = imageDrops
                }
            }
            
            return cell
        } else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionView", for: indexPath) as? CastCollectionViewCell else {return UICollectionViewCell()}
            
            guard  let vmC = self.castViewModel else {return cell}
//            let imagePathBackdrops = vmC.getBackdrop()
            cell.castActorName.text = vmC.getCastName()
//            cell.castActorCharacter.text = vmC.getCastActor()
            
//            if imagePathBackdrops == "" {return cell}
//
//            let imageUrlBackdrops = URL(string: imageBaseUrl + (imagePathBackdrops))
//            DispatchQueue.global(qos: .background).async {
//                guard let data = try? Data(contentsOf: imageUrlBackdrops!) else {return}
//                DispatchQueue.main.async {
//                    let imageDrops = UIImage(data: data)
//                    cell.backdrops.image = imageDrops
//                }
//            }
            
            return cell
        }
    }
    
    
}


extension DetailView: DownloadDelegate {
    func didFinishDownload() {
        DispatchQueue.main.async {
            self.setupMovieDetail()
//            self.activityIndicator.isHidden = true
        }
    }
    
    
}
