//
//  NewsItem.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import Foundation

struct NewsItem: Decodable {
    let id: Int?
    let title: String?
    let date: String?
    let description: String?
    let image: Image?
    let link: String?
    let author: Author?
}
