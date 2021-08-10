//
//  NewsFeedViewController+TVDataSource.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import UIKit

extension NewsFeedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemTableCell.identifier, for: indexPath) as! NewsItemTableCell
        
        if let item = viewModel.items.value?[indexPath.row] {
            let viewModel = NewsItemViewModel(withNewsItem: item)
            cell.configure(withViewModel: viewModel)
        }
        return cell
    }
}
