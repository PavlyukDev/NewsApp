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
    private var page: UInt = 1
    private var totalCount = 0
    var isLoading: Bool = false
    var articles: MutableProperty<[Article]> = MutableProperty([])
    let model: NewsModel
    let sourceId: String

    init(model: NewsModel, sourceId: String) {
        self.model = model
        self.sourceId = sourceId
    }

    func loadArticles() {
        isLoading = true
        model.loadNews(with: sourceId, page: page).startWithResult { [weak self] (result) in
            self?.isLoading = false
            switch result {
            case let .success(response):
                self?.totalCount = response.totalResults
                self?.page += 1
                self?.articles.value.append(contentsOf: response.articles)
            case .failure(_):
                break
            }
        }
    }

    func loadMore() {
        guard totalCount > articles.value.count, !isLoading else { return }
        loadArticles()
    }
}
