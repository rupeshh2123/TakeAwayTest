//
//  ArticleRequest.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation

enum PopularType{
    case viewed
    case shared
    case emailed
}

class ArticleRequest {
    private let mostEmailedAPIEndPoint = "mostpopular/v2/emailed/7.json?api-key=$apiKey&offset=$offset"
    private let mostSharedAPIEndPoint = "mostpopular/v2/shared/7.json?api-key=$apiKey&offset=$offset"
    private let mostViewedAPIEndPoint = "mostpopular/v2/viewed/7.json?api-key=$apiKey&offset=$offset"

    func getArticles(for type: PopularType, offset: Int,  _ success: @escaping (Article) -> Void, failure: @escaping (Error?) -> Void, useMockData: Bool = false) {
        
        guard !useMockData else  {
            return mockData(success, failure: failure)
        }
        var requestUrl: String = ""
        if type == .emailed {
            requestUrl = Constants.API.baseUrl + mostEmailedAPIEndPoint.replacingOccurrences(of: "$apiKey", with: Constants.apiKey).replacingOccurrences(of: "$offset", with: "\(offset)")
        }
        if type == .shared {
            requestUrl = Constants.API.baseUrl + mostSharedAPIEndPoint.replacingOccurrences(of: "$apiKey", with: Constants.apiKey).replacingOccurrences(of: "$offset", with: "\(offset)")
        }
        if type == .viewed {
            requestUrl = Constants.API.baseUrl + mostViewedAPIEndPoint.replacingOccurrences(of: "$apiKey", with: Constants.apiKey).replacingOccurrences(of: "$offset", with: "\(offset)")
        }
        let request = SessionManager.sharedInstance.request(requestUrl, method: .get)
        print("GetArticleRequest: \(request.request!.url!.absoluteString)")
        request.validate().responseJSON { response in
            switch response.result {
            case .success( _):
                let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
                print("GetArticleResponse: \(responseString!)")
                let decoder = JSONDecoder()
                do {
                    let response  = try decoder.decode(Article.self, from: response.data!)
                    success(response)
                }
                catch (let error) {
                    print(error)
                }
                
            case .failure(let error):
                var statusCode = 0
                if let responseStatusCode = response.response?.statusCode {
                    statusCode = responseStatusCode
                }
                failure(ErrorInfo(title: Constants.articleDetailsFailed, statusCode: statusCode, code: error._code, description: error.localizedDescription))
            }
        }
        request.resume()
    }
    
    func mockData(_ success: @escaping (Article) -> Void, failure: @escaping (Error?) -> Void) {
        if let jsonData = FileReader.contentsOfFileInBundle("GetArticle") {
            let decoder = JSONDecoder()
            do {
                let response  = try decoder.decode(Article.self, from: jsonData)
                success(response)
            }
            catch (let error) {
                print(error)
            }
        }
    }
}
