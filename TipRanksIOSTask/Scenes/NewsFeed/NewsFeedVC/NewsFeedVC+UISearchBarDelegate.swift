//
//  NewsFeedVC+UISearchBarDelegate.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 09/08/2021.
//

import UIKit

extension NewsFeedVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        viewModel.searchNews(text)
        
        if searchBar.canResignFirstResponder {
            searchBar.resignFirstResponder()
        }
        noResultsLabel.isHidden = true
        spinner.startAnimating()
    }
}
