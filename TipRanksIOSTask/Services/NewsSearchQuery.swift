//
//  NewsSearchQuery.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import Foundation

struct NewsSearchQuery: Encodable {
    static let perPage: Int = 20
    static let startPage: Int = 1
    
    var page = NewsSearchQuery.startPage
    var searchQuery = ""
    
    var queryStrUrl: String {
        return "page=\(page)&per_page=\(NewsSearchQuery.perPage)&search=\(searchQuery)"
    }
    
    init(page: Int = startPage, searchQuery: String) {
        self.page = page
        self.searchQuery = searchQuery
    }
    
    static func isValidSearch(_ query: String) -> Bool {
        return !query.isEmpty
    }
}
