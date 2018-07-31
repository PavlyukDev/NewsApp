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
    @IBOutlet weak var articleDescription: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publishedDate: UILabel!

    func setup(with article: Article) {
        title.text = article.title
        author.text = article.author ?? "Unknown"
        articleImage.kf.setImage(with: article.urlToImage,
                                 placeholder: #imageLiteral(resourceName: "icon_news_image_placeholder"))
        publishedDate.text = setupPublishedDate(article.publishedAt)
        let imagePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 140, height: 70))
        articleDescription.textContainer.exclusionPaths = [imagePath]
        articleDescription.text = article.description
    }

    private func setupPublishedDate(_ publishedAt: String?) -> String? {
        guard let publishedAt = publishedAt?.split(separator: "T").first else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let localDate = formatter.date(from: String(publishedAt)) else { return nil }
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: localDate)
    }
}
