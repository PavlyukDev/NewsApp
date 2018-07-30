//
//  SourcesViewController.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit
import SkeletonView

class SourcesViewController: UIViewController {
    var viewModel: SourcesViewModel!
    @IBOutlet weak var tableView: UITableView!



    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadSources()
        bind()
        setupTableView()
        view.showAnimatedGradientSkeleton()

        title = "Sources"
    }

    private func bind() {
        viewModel.sources.signal.observeValues {[weak self] _ in
            DispatchQueue.main.async {
                self?.finishLoading()
                self?.tableView.reloadData()
            }
        }

        viewModel.errorMessage.signal.observeValues { [weak self] value in
            DispatchQueue.main.async {
                self?.finishLoading()
            }
        }
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.isSkeletonable = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140

        tableView.register(UINib.init(nibName: String(describing: SourceTableViewCell.self),
                                      bundle: Bundle.main),
                           forCellReuseIdentifier: "SourceCell")
        tableView.register(UINib.init(nibName: String(describing: SkeletonCell.self),
                                      bundle: Bundle.main),
                           forCellReuseIdentifier: "SkeletonCell")
    }

    private func finishLoading() {
        if view.isSkeletonActive {
            view.hideSkeleton()
        }
    }
}

extension SourcesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.openSource(byIndex: indexPath.row)
    }
}

extension SourcesViewController: SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sources.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as? SourceTableViewCell
        let source = viewModel.sources.value[indexPath.row]
        cell?.setup(with: source)
        return cell ?? UITableViewCell()
    }

    public func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 3
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    {
        return "SkeletonCell"
    }
}
