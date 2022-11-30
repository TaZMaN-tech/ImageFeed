//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Тадевос Курдоглян on 29.11.2022.
//

import UIKit

class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!

}
