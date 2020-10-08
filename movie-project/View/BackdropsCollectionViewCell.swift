//
//  BackdropsCollectionViewCell.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import UIKit

class BackdropsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var backdrops: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var viewModel : DetailViewModel?
    var imagesBackdropsList: MovieImages?
    var id : Int?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

