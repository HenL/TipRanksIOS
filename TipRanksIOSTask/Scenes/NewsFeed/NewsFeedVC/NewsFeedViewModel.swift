//
//  NewsFeedViewModel.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import Foundation
import CoreGraphics

class NewsFeedViewModel {
    var items = Bindable<[NewsItem]>()
    var insertItemsAction: (([IndexPath]) -> ())?
    var hideBottomSpinner: (()->())?
    var heightAtIndexPath = [IndexPath: CGFloat]()
    var isLoading = false
    var endOfPages = false
    var currentQuery: NewsSearchQuery?
    private var currentPage: Int {
        return currentQuery?.page ?? NewsSearchQuery.startPage
    }
    var isStartPage: Bool {
        return currentPage == NewsSearchQuery.startPage
    }
    var numberOfItems: Int {
        return items.value?.count ?? 0
    }
    
    func searchNews(_ text: String? = nil) {
        guard !isLoading,
              let searchText = text ?? currentQuery?.searchQuery else {
            return
        }
        
        // reset paging if search query changed (or null)
        if currentQuery?.searchQuery != searchText {
            currentQuery = NewsSearchQuery(searchQuery: searchText)
            items.value?.removeAll()
            endOfPages = false
        }
        // or continue to next page
        else {
            currentQuery?.page += 1
        }
        
        // request
        if !endOfPages {
            requestSearchNews()
        } else {
            hideBottomSpinner?()
        }
    }
    
    private func requestSearchNews() {
        guard let current = currentQuery else {
            return
        }
        isLoading = true
        API.shared.searchNews(searchQuery: current) { [weak self] response in
            self?.handleResponse(response, page: current.page)
        } failure: { [weak self] serviceError in
            print(serviceError)
            self?.handleFailure(serviceError)
        }
    }
    
    private func handleFailure(_ serviceError: ServiceError) {
        isLoading = false
        endOfPages = serviceError == .notFound
        hideBottomSpinner?()
    }
    
    private func handleResponse(_ response: NewsResponse, page: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration) { [weak self] in
            self?.isLoading = false
        }
        
        let responseItems = response.data ?? [NewsItem]()
        if page == NewsSearchQuery.startPage {
            items.value?.removeAll()
        }
        var currentItems = items.value ?? [NewsItem]()
        endOfPages = responseItems.count < NewsSearchQuery.perPage
        
        let currentItemsCount = currentItems.count
        var insertIndexPaths = [IndexPath]()
        for i in currentItemsCount ..< (currentItemsCount + responseItems.count) {
            insertIndexPaths.append(IndexPath(row: i, section: 0))
        }
        currentItems.append(contentsOf: responseItems)
        
        // reload
        if currentItemsCount == 0 {
            items.value = responseItems
        }
        // insert
        else {
            items.value?.append(contentsOf: responseItems)
            insertItemsAction?(insertIndexPaths)
            hideBottomSpinner?()
        }
    }
}
