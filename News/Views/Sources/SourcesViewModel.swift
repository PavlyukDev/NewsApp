//
//  SourcesViewModel.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import ReactiveSwift

class SourcesViewModel {
    private let model: SourcesModel
    var openHandler: (_ sourceId: String) -> Void
    var sources: MutableProperty<[Source]> = MutableProperty([])

    init(model: SourcesModel, openHandler: @escaping (String) -> Void) {
        self.model = model
        self.openHandler = openHandler
    }

    func loadSources() {
        model.loadSources().startWithResult { [weak self] result in
            switch result {
            case let .success(response):
                self?.sources.value = response.sources
            case .failure(_):
                break
            }
        }
    }

    func openSource(byIndex index: Int) {
        openHandler(
            sources.value[index].id)
    }
}
