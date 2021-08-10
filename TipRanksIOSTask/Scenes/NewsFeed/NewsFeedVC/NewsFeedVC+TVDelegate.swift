//
//  NewsFeedVC+TVDelegate.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import UIKit

extension NewsFeedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "NewsArticleSegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.viewModel.heightAtIndexPath[indexPath] {
            return height
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let height = cell.frame.size.height
        self.viewModel.heightAtIndexPath[indexPath] = height
    }
}
