//
//  NewsResponse.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import Foundation

struct NewsResponse: Decodable {
    let data: [NewsItem]?
}
