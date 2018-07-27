//
//  ApplicationCoordicator.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
    override func start() {
        let coordinator = NewsCoordinator(router: router)
        coordinator.start()
        addChildCoordinator(coordinator)
    }
}
