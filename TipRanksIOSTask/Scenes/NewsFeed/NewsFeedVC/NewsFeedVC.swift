//
//  NewsFeedVC.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import UIKit

class NewsFeedVC: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLabel: UILabel!
    var viewModel = NewsFeedViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        registerCell()
        setupBottomSpinner()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !searchBar.isFirstResponder, searchBar.canBecomeFirstResponder {
            searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Bind
    
    func bind() {
        viewModel.items.bind { [weak self] items in
            if let `self` = self,
               self.viewModel.isStartPage == true {
                self.table.reloadData()
                self.spinner.stopAnimating()
                if let `items` = items {
                    self.noResultsLabel.isHidden = !items.isEmpty
                }
            }
        }
        viewModel.insertItemsAction = { [weak self] indexPaths in
            if let `self` = self {
                UIView.performWithoutAnimation {
                    self.table.beginUpdates()
                    self.table.insertRows(at: indexPaths, with: .none)
                    self.table.endUpdates()
                }
            }
        }
        viewModel.hideBottomSpinner = { [weak self] in
            self?.table.tableFooterView?.isHidden = true
        }
    }
    
    // MARK: - Register Cell
    
    func registerCell() {
        table.register(NewsItemTableCell.self, forCellReuseIdentifier: NewsItemTableCell.identifier)
        table.register(UINib(nibName: "NewsItemTableCell", bundle: nil), forCellReuseIdentifier: NewsItemTableCell.identifier)
    }
    
    // MARK: - 'Load More' Spinner
    
    func setupBottomSpinner() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0))
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        
        table.tableFooterView = footerView
        table.tableFooterView?.isHidden = true
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewsArticleVC,
           let indexPath = sender as? IndexPath,
           let linkStr = viewModel.items.value?[indexPath.row].link,
           let link = URL(string: linkStr) {
            
            destination.viewModel = NewsArticleViewModel(link: link)
        }
    }
}

