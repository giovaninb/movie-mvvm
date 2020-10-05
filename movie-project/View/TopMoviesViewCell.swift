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
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.viewRoot.layer.cornerRadius = 10
        self.cover.layer.cornerRadius = 16
    }
    

}


