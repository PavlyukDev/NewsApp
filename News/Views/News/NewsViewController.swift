//
//  NewsViewController.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit
import Core

class NewsViewController: UIViewController {
    var viewModel: NewsViewModel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadArticles()
        bind()
        setupTableView()
        view.showAnimatedGradientSkeleton()
        title = "Top headlines"
    }

    private func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: String(describing: ArticleTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: "ArticleCell")
        tableView.register(UINib.init(nibName: String(describing: SkeletonCell.self), bundle: Bundle.main), forCellReuseIdentifier: "SkeletonCell")
    }

    private func bind() {
        viewModel.articles.signal.observeValues({ [weak self] _ in
            DispatchQueue.main.async {
                self?.view.hideSkeleton()
                self?.tableView.reloadData()
            }
        })
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleTableViewCell
        let article = viewModel.articles.value[indexPath.row]
        cell?.setup(with: article)
        if indexPath.row >= viewModel.articles.value.count - 2 {
            viewModel.loadMore()
        }
        return cell ?? UITableViewCell()
    }
}
