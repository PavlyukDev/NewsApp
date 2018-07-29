//
//  SourcesViewController.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController {
    var viewModel: SourcesViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadSources()
        bind()
        setupTableView()
        tableView.tableFooterView = UIView()
        title = "Sources"
    }

    private func bind() {
        viewModel.sources.signal.observeValues {[weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.register(UINib.init(nibName: String(describing: SourceTableViewCell.self),
                                      bundle: Bundle.main),
                           forCellReuseIdentifier: "SourceCell")
    }
}

extension SourcesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sources.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as? SourceTableViewCell
        let source = viewModel.sources.value[indexPath.row]
        cell?.setup(with: source)
        return cell ?? UITableViewCell()
    }
}

extension SourcesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.openSource(byIndex: indexPath.row)
    }
}
