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
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionImages: UICollectionView!
    @IBOutlet weak var collectionCasts: UICollectionView!
    
    
    var detailViewModel: DetailViewModel?
    var backdropViewModel: BackdropsListViewModel?
    var castViewModel: CastListViewModel?
    
    var currentIndex = 0
    var id : Int?
    let imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewModel = DetailViewModel(id: self.id!)
        self.backdropViewModel = BackdropsListViewModel(id: self.id!)
        self.castViewModel = CastListViewModel(id: self.id!)
        
        collectionImages.delegate = self
        collectionImages.dataSource = self
        collectionCasts.delegate = self
        collectionCasts.dataSource = self
        
        self.rating.layer.cornerRadius = (rating?.frame.size.height)!/4.0
        self.rating?.layer.masksToBounds = true
        self.cover.layer.cornerRadius = 26
        self.cover.layer.borderWidth = 2
        self.cover.layer.borderColor = #colorLiteral(red: 0.3833134472, green: 0.8329965472, blue: 0.46416682, alpha: 1)
        self.overview.sizeToFit()
                
        detailViewModel?.downloadDelegate = self
        backdropViewModel?.downloadDelegate = self
        castViewModel?.downloadDelegate = self
        setupMovieDetail()
    }
    
    func setupMovieDetail() {
        guard let viewModel = self.detailViewModel else {return}
        guard let bViewModel = self.backdropViewModel else { return }
        movieTitle.text = viewModel.getTitle()
        rating.text = viewModel.getPopularity()
        overview.text = viewModel.getOverview()
        duration.text = "Duração: " + viewModel.getRuntime()
        pageControl.numberOfPages = bViewModel.getBackDropsCount()
        
        // Load Images
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
   

extension DetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionImages {
            return self.backdropViewModel?.getBackDropsCount() ?? 0
        } else if collectionView == self.collectionCasts {
            return self.castViewModel?.getCastCount() ?? 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionImages {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieImagesCollectionViewCell", for: indexPath) as? BackdropsCollectionViewCell else {return UICollectionViewCell()}
            let movieImageIndex = indexPath.row
            
            guard let vmB = self.backdropViewModel else {return cell}
            let imagePathBackdrops = vmB.getBackdrops(byIndexPath: movieImageIndex)
            if imagePathBackdrops == "" {return cell}

            let imageUrlBackdrops = URL(string: imageBaseUrl + (imagePathBackdrops))
//            print(imageUrlBackdrops!)
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: imageUrlBackdrops!) else {return}
                DispatchQueue.main.async {
                    let imageDrops = UIImage(data: data)
                    cell.backdrops.image = imageDrops
                }
            }
            return cell
        } else if collectionView == self.collectionCasts {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionView", for: indexPath) as? CastCollectionViewCell else {return UICollectionViewCell()}
            let movieCastIndex = indexPath.row

            guard  let vmC = self.castViewModel else {return cell}
            cell.castActorName.text = vmC.getCastName(byIndexPath: movieCastIndex)
            cell.castActorCharacter.text = vmC.getCastCharacter(byIndexPath: movieCastIndex)
            
            let imagePathCast = vmC.getCastPhoto(byIndexPath: movieCastIndex)
            if imagePathCast == "" {return cell}

            let imageUrlCast = URL(string: imageBaseUrl + (imagePathCast))
            print(imageUrlCast!)
            DispatchQueue.global(qos: .background).async {
                guard let data = try? Data(contentsOf: imageUrlCast!) else {return}
                DispatchQueue.main.async {
                    let imageCast = UIImage(data: data)
                    cell.castPhoto.image = imageCast
                }
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionImages {
            return CGSize(width: collectionImages.frame.width, height: collectionImages.frame.height)
        } else if collectionView == self.collectionCasts {
            return CGSize(width: 135, height: 170)
        }
        return CGSize()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionImages {
            currentIndex = Int(scrollView.contentOffset.x / collectionImages.frame.size.width)
            pageControl.currentPage = currentIndex
        }
    }
    
}


extension DetailView: DownloadDelegate {
    func didFinishDownload() {
        DispatchQueue.main.async {
            self.setupMovieDetail()
            self.collectionImages.reloadData()
            self.pageControl.reloadInputViews()
            self.collectionCasts.reloadData()
//            self.activityIndicator.isHidden = true
        }
    }
    
    
}
