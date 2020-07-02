//
//  ProductDetailViewController.swift
//  AppDrLab
//
//  Created by Han Luong on 6/5/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

class ProductDetailViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productCountLikeLabel: UILabel!
    @IBOutlet weak var productCountReplyLabel: UILabel!
    @IBOutlet weak var productWebView: WKWebView!
    
    // MARK: - Vars
    var selectedProductViewModel: ProductViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        productImageView.downloaded(from: selectedProductViewModel!.imagePath)
        productTitleLabel.text = selectedProductViewModel?.title
        categoryNameLabel.text = selectedProductViewModel?.categoryName
        dateLabel.text = selectedProductViewModel?.date
        productCountLikeLabel.text = selectedProductViewModel?.countLike
        productCountReplyLabel.text = selectedProductViewModel?.countRep
        productWebView.scrollView.showsVerticalScrollIndicator = false
        productWebView.scrollView.showsHorizontalScrollIndicator = false
        if let resource = selectedProductViewModel?.detail {
            KRProgressHUD.show()
            WebService().load(resource: resource) { [weak self] result in
                KRProgressHUD.dismiss()
                switch result {
                case .failure(let error):
                    self?.productWebView.loadHTMLString(error.localizedDescription, baseURL: nil)
                case .success(let html):
                    self?.productWebView.loadHTMLString(html!.contents, baseURL: nil)
                }
            }
        }
    }
}
