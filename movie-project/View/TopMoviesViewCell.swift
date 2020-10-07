//
//  TopMoviesViewCell.swift
//  movie-project
//
//  Created by Giovani Nícolas Bettoni on 03/10/20.
//

import UIKit

class TopMoviesViewCell: UITableViewCell {

    
    @IBOutlet weak var viewRoot: UIView!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var year: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.rating.layer.cornerRadius = (rating?.frame.size.height)!/4.0
        self.rating?.layer.masksToBounds = true
        self.viewRoot.layer.cornerRadius = 20
        self.cover.layer.cornerRadius = 10
        self.cover.layer.borderWidth = 2
        self.cover.layer.borderColor = #colorLiteral(red: 0.3833134472, green: 0.8329965472, blue: 0.46416682, alpha: 1)
    }
    

}


