//
//  SourceTableViewCell.swift
//  News
//
//  Created by Vitaliy Pavlyuk on 7/29/18.
//  Copyright © 2018 Vitaliy Pavlyuk. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    @IBOutlet weak var sourceTitle: UILabel!
    @IBOutlet weak var sourceDescription: UILabel!
    @IBOutlet weak var sourceUrl: UILabel!

    func setup(with source: Source) {
        sourceTitle.text = source.name
        sourceDescription.text = source.description
        sourceUrl.text = source.url.absoluteString
    }
}
