//
//  CategoryViewController.swift
//  AppDrLab
//
//  Created by Han Luong on 6/4/20.
//  Copyright © 2020 Han Luong. All rights reserved.
//

import UIKit
import KRProgressHUD
import ScrollableSegmentedControl

class CategoryViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Vars
    private var productListViewModel = ProductListViewModel()
    private var categoryListViewModel = CategoryListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        WebService().load(resource: Category.all) { [weak self] result in
            switch result {
            case .success(let categoryList):
                if let categoryList = categoryList {
                    self?.categoryListViewModel.categoriesViewModel = categoryList.categories.map(CategoryViewModel.init)
                }
                self?.setupSegmentedControl()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupSegmentedControl() {
        segmentedControl.segmentStyle = .textOnly
        for (index, categoryViewModel) in categoryListViewModel.categoriesViewModel.enumerated() {
            segmentedControl.insertSegment(withTitle: categoryViewModel.name, at: index)
        }
            
        segmentedControl.underlineSelected = true
            
        segmentedControl.addTarget(self, action: #selector(CategoryViewController.segmentSelected(sender:)), for: .valueChanged)

        // change some colors
        segmentedControl.segmentContentColor = .black
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentContentColor = UIColor(red: 67/255, green: 175/255, blue: 216/255, alpha: 1.0)
        segmentedControl.backgroundColor = .white
        
        // Turn off all segments been fixed/equal width.
        // The width of each segment would be based on the text length and font size.
        segmentedControl.fixedSegmentWidth = false
        
        // default selection
        segmentedControl.selectedSegmentIndex = 0
        getProductBy(categoryId: self.categoryListViewModel.categoryViewModel(at: 0).id)
    }
    
    private func getProductBy(categoryId: String) {
        KRProgressHUD.show()
        WebService().load(resource: Category.getProduct(by: categoryId)) { [weak self] result in
            KRProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let productList):
                if let productList = productList {
                    self?.productListViewModel.productsViewModel = productList.products.map(ProductViewModel.init)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        productListViewModel = ProductListViewModel()
        tableView.reloadData()
        getProductBy(categoryId: self.categoryListViewModel.categoryViewModel(at: sender.selectedSegmentIndex).id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductDetailViewController", let indexPath = tableView.indexPathForSelectedRow {
            let productDetailVC = segue.destination as! ProductDetailViewController
            productDetailVC.selectedProductViewModel = productListViewModel.productViewModel(at: indexPath.row)
        }
    }

}

extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productListViewModel.productsViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MartCategoryTableViewCell", for: indexPath) as? MartCategoryTableViewCell else { return UITableViewCell() }
        cell.configCell(vm: self.productListViewModel.productViewModel(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
}
