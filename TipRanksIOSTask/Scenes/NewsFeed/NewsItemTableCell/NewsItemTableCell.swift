//
//  NewsItemTableCell.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import UIKit

class NewsItemTableCell: UITableViewCell {
    static let identifier = "NewsItemTableCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    func configure(withViewModel viewModel: NewsItemViewModel) {
        postImageView.setImage(withUrl: viewModel.imageUrl)
        authorImageView.setImage(withUrl: viewModel.authorImageUrl)
        headlineLabel.text = viewModel.headline
        authorNameLabel.text = viewModel.authorName
        dateLabel.text = viewModel.formattedDate
        descriptionTextView.attributedText = viewModel.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        descriptionTextView.textContainer.maximumNumberOfLines = 2
    }
}
