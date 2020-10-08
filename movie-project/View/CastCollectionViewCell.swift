//
//  CastCollectionViewCell.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 07/10/20.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var castPhoto: UIImageView!
    @IBOutlet weak var castActorName: UILabel!
    @IBOutlet weak var castActorCharacter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castPhoto.layer.cornerRadius = (castPhoto.frame.width / 2)
        castPhoto.layer.masksToBounds = true
    }
    
}
