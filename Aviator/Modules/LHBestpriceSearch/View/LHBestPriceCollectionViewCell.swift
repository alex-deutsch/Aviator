//
//  LHBestPriceCollectionViewCell.swift
//  Aviator
//
//  Created by Alexander Deutsch on 17.11.18.
//  Copyright © 2018 Alexander Deutsch. All rights reserved.
//

import UIKit
import F1reKit

class LHBestPriceCollectionViewCell: UICollectionViewCell, ReusableCell {

    static let identifier: String = "LHBestPriceCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var centerLabelTop: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!

    var clickURLString: String? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 9.0
        clipsToBounds = false
        backgroundColor = .white
    }


    func configure(with model: LHBestPriceResultViewModel) {
        titleLabel.text = model.fromTo
        centerLabelTop.text = model.dateString
        bottomRightLabel.text = model.price + " " + model.currency
        clickURLString = model.linkURLString
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        centerLabelTop.text = nil
        bottomRightLabel.text = nil
        clickURLString = nil
    }
}
