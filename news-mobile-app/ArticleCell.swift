//
//  ArticleCell.swift
//  news-mobile-app
//
//  Created by Damian Mikołajczak on 26/06/2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
}
