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
    private var dataSource: [Article] = []
    var network: NetworkProtocol!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Move to Core
        network.sendRequest(endpoint: NewsEndPoint.topHeadlines) {[weak self] (data, response, error) in
            guard let data = data else { return }
            do {
                let newsResponse = try JSONDecoder().decode(Response.self, from: data)
                self?.dataSource = newsResponse.articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        let article = dataSource[indexPath.row]
        cell.textLabel?.text = article.title
        return cell
    }
}
