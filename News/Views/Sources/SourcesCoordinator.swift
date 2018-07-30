//
//  SourcesCoordinator.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import Core

class SourcesCoordinator: BaseCoordinator {
    let network = Network(baseUrl: URL(string: "https://newsapi.org/v2/")!)

    override func start() {
        let model = SourcesModel(network: network)
        let viewModel = SourcesViewModel(model: model, openHandler: { [weak self] sourceId
 in
            self?.startNewsCoordinator(with: sourceId)
        })
        let viewController: SourcesViewController = SourcesViewController.instantiate(storyboardName: "Main")
        viewController.viewModel = viewModel
        router.push(viewController)
    }

    private func startNewsCoordinator(with sourceId: String) {
        let model = NewsModel(network: network)
        let viewModel = NewsViewModel(model: model, sourceId: sourceId)
        let viewController: NewsViewController = NewsViewController.instantiate(storyboardName: "Main")
        viewController.viewModel = viewModel
        router.push(viewController)
    }
}
