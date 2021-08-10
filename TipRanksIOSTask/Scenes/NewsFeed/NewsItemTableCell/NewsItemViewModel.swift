//
//  NewsItemViewModel.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import UIKit

class NewsItemViewModel {
    private let item: NewsItem?
    
    var headline: String? {
        return item?.title
    }
    var formattedDate: String? {
        if let dateString = item?.date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Constants.dateTimeFormat
            let date = dateFormatter.date(from: dateString)
            return date?.timeAgo
        }
        return nil
    }
    var imageUrl: URL? {
        if let urlStr = item?.image?.src {
            return URL(string: urlStr)
        }
        return nil
    }
    var authorImageUrl: URL? {
        if let urlStr = item?.author?.image?.src {
            return URL(string: urlStr)
        }
        return nil
    }
    var authorName: String? {
        return item?.author?.name
    }
    var description: NSAttributedString? {
        return item?.description?.decodeHTMLToAttrString()
    }
    var postLinkUrl: URL? {
        if let urlStr = item?.link {
            return URL(string: urlStr)
        }
        return nil
    }
    
    init(withNewsItem newsItem: NewsItem) {
        self.item = newsItem
    }
}
