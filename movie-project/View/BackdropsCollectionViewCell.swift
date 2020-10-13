//
//  BackdropsCollectionViewCell.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import UIKit

class BackdropsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var backdrops: UIImageView!
    
    var imageBackdrop: UIImage! {
        didSet {
            backdrops.image = imageBackdrop
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

