//
//  SessionManager.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 8/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Alamofire

class SessionManager
{
    static let sharedInstance = SessionManager()
    private let alamofireManager = Alamofire.SessionManager.default
    
    private init()
    {
        alamofireManager.startRequestsImmediately = false
    }
    
    func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil) -> DataRequest
    {
        return alamofireManager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    func cancelAllRequests()
    {
        alamofireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                for task in dataTasks
                {
                    task.cancel()
                }
        }
    }
    
    func cancelAllRequestsWithUrlPart(_ urlPartString: String)
    {
        alamofireManager.session.getTasksWithCompletionHandler
            {
                dataTasks, uploadTasks, downloadTasks in
                for task in dataTasks
                {
                    if task.originalRequest!.url!.absoluteString.contains(urlPartString) { task.cancel() }
                }
        }
    }
}
