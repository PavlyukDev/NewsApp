//
//  NewsViewModel.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import ReactiveSwift
import Core

class NewsViewModel {
    var articles: MutableProperty<[Article]> = MutableProperty([])
    let model: NewsModel
    let sourceId: String

    init(model: NewsModel, sourceId: String) {
        self.model = model
        self.sourceId = sourceId
    }

    func loadArticles() {
        model.loadNews(with: sourceId).startWithResult { [weak self] (result) in
            switch result {
            case let .success(response):
                self?.articles.value = response.articles
            case .failure(_):
                break
            }
        }
    }
}
