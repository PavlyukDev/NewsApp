//
//  Router.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit

class Router: NSObject {
    typealias Completion = () -> Void
    private var popCompletions: [UIViewController: Completion] = [:]
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        push(viewController, animated: animated, popCompletion: nil)
    }

    func push(_ viewController: UIViewController, animated: Bool = true, popCompletion: Completion?) {
        if let popCompletion = popCompletion {
            popCompletions[viewController] = popCompletion
        }
        navigationController.pushViewController(viewController, animated: animated)
    }
}

extension Router: UINavigationControllerDelegate {
    
}
