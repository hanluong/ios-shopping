//
//  MartProductDetailViewController.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit
import WebKit

class MartProductDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productCountLikeLabel: UILabel!
    @IBOutlet weak var productCountReplyLabel: UILabel!
    @IBOutlet weak var productWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
