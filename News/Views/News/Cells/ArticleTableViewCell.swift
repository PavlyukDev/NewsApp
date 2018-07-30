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
    @IBOutlet weak var publishedDate: UILabel!

    func setup(with article: Article) {
        title.text = article.title
        articleDescription.text = article.description
        author.text = article.author ?? "Unknown"
        articleImage.kf.setImage(with: article.urlToImage,
                                 placeholder: #imageLiteral(resourceName: "icon_news_image_placeholder"),
                                 options: nil,
                                 progressBlock: nil,
                                 completionHandler: nil)
        publishedDate.text = setupPublishedDate(article.publishedAt)
    }

    private func setupPublishedDate(_ publishedAt: String?) -> String? {
        guard let publishedAt = publishedAt?.split(separator: "T").first else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: Date()))
        guard let localDate = formatter.date(from: String(publishedAt)) else { return nil }
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: localDate)
    }
}
