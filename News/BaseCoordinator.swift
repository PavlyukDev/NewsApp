//
//  BaseCoordinator.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordicator {
    let router: Router
    private(set) var childCoordinators: [Coordicator] = []

    init(router: Router) {
        self.router = router
    }

    func start() {
        assertionFailure("must be implemented in subclasses")
    }

    final func addChildCoordinator(_ coordinator: Coordicator) {
        childCoordinators.append(coordinator)
    }

    final func removeChildCoordinator(_ coordinator: Coordicator) {
        guard let index = childCoordinators.index(where: {$0 === coordinator}) else { return }
        childCoordinators.remove(at: index)
    }
}
