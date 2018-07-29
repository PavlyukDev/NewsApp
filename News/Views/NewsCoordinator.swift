//
//  NewsCoordinator.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation
import Core

class NewsCoordinator: BaseCoordinator {
    override func start() {
        let network = Network(baseUrl: URL(string: "https://newsapi.org/v2/")!)
        let model = NewsModel(network: network)
        let viewModel = NewsViewModel(model: model)
        let viewController: NewsViewController = NewsViewController.instantiate(storyboardName: "Main")
        viewController.viewModel = viewModel
        router.push(viewController)
    }
}
