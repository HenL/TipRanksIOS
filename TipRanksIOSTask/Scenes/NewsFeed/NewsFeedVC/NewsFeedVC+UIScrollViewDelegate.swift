//
//  NewsFeedVC+UIScrollViewDelegate.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import UIKit

extension NewsFeedVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (table.contentSize.height - self.view.frame.height) < table.contentOffset.y, viewModel.numberOfItems > 0 {
            table.tableFooterView?.isHidden = false
            viewModel.searchNews()
        }
    }
}
