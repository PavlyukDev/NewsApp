//
//  NewsViewController.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/27/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit
import Core
import SkeletonView

class NewsViewController: BaseViewController {
    var viewModel: NewsViewModel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupTableView()
        title = "Everything"
        viewModel.loadArticles()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.isSkeletonable = true
        tableView.estimatedRowHeight = 150
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib.init(nibName: String(describing: ArticleTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: "ArticleCell")
        tableView.register(UINib.init(nibName: String(describing: SkeletonCell.self), bundle: Bundle.main), forCellReuseIdentifier: "SkeletonCell")
    }

    private func bind() {
        viewModel.articles.signal.observeValues({ [weak self] _ in
            DispatchQueue.main.async {
                self?.finishLoading()
                self?.tableView.reloadData()
            }
        })

        viewModel.errorMessage.signal.observeValues({[weak self] message in
            DispatchQueue.main.async {
                self?.finishLoading()
                self?.showOkAlert(title: "Cannot load data", message: message)
            }
        })
    }

    override func refresh() {
        viewModel.loadArticles()
    }

    private func finishLoading() {
        view.hideSkeleton()
        refreshControl.endRefreshing()
    }
}

extension NewsViewController: SkeletonTableViewDataSource {
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

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return 3
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier
    {
        return "SkeletonCell"
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
