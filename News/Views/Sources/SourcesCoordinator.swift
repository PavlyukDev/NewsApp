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
    override func start() {
        let network = Network(baseUrl: URL(string: "https://newsapi.org/v2/")!)
        let model = SourcesModel(network: network)
        let viewModel = SourcesViewModel(model: model)
        let viewController: SourcesViewController = SourcesViewController.instantiate(storyboardName: "Main")
        viewController.viewModel = viewModel
        router.push(viewController)
    }
}
