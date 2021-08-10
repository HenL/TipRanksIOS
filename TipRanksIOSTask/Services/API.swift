//
//  API.swift
//  TipRanksIOSTask
//
//  Created by Hen Levy on 08/08/2021.
//

import Foundation

class API {
    static let shared = API()
    
    let searchNewsUrl = "https://www.tipranks.com/api/news/posts"

    func searchNews(searchQuery: NewsSearchQuery,
                    success: ((NewsResponse) -> ())?,
                    failure: ((ServiceError)->())?) {
        
        // prepare url
        let strUrl = "\(searchNewsUrl)?\(searchQuery.queryStrUrl)"
        guard let url = URL(string: strUrl) else {
            failure?(ServiceError.generalError)
            return
        }
        
        // request
        debugPrint(strUrl)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // error handling
            if let serviceError = self.hasErrors(data: data, response: response, error: error) {
                failure?(serviceError)
                return
            }
            
            // parse json
            guard let `data` = data else {
                failure?(.generalError)
                return
            }
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodeResponse = try jsonDecoder.decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    success?(decodeResponse)
                }
            } catch {
                DispatchQueue.main.async {
                    failure?(ServiceError.generalError)
                }
            }
        }.resume()
    }
    
    private func hasErrors(data: Data?, response: URLResponse?, error: Error?) -> ServiceError? {
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode != 404 else {
            return ServiceError.notFound
        }
        guard error == nil || data != nil else {
            return ServiceError.generalError
        }
        return nil
    }
}

