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
    init(model: NewsModel) {
        self.model = model
    }

    func loadArticles() {
        model.loadNews().startWithResult { (result) in
            switch result {
            case let .success(response):
                self.articles.value = response.articles
            case .failure(_):
                break
            }
        }
    }
}
