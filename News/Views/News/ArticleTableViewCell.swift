//
//  ArticleTableViewCell.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit
import Kingfisher
import Core

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var author: UILabel!

    func setup(with article: Article) {
        title.text = article.title
        articleDescription.text = article.description
        author.text = article.author ?? "Unknown"
        articleImage.kf.setImage(with: article.urlToImage,
                                 placeholder: #imageLiteral(resourceName: "icon_news_image_placeholder"),
                                 options: nil,
                                 progressBlock: nil,
                                 completionHandler: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
