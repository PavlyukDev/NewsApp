//
//  UIViewController+RefreshControl.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/31/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private(set) lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()

    @objc func refresh() {

    }
}
