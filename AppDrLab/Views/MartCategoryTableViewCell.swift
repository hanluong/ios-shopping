//
//  MartCategoryTableViewCell.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit

class MartCategoryTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var channelItemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var countHeartLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var countButtonLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(vm: ProductViewModel) {
        channelItemImageView.downloaded(from: vm.imagePath)
        titleLabel.text = vm.title
        channelTitleLabel.text = vm.categoryName
        dateLabel.text = vm.date
        countHeartLabel.text = vm.countLike
        countButtonLabel.text = vm.countRep
    }

}
