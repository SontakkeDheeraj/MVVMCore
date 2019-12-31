//
//  APIManager.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import Foundation
struct WebServiceConstants {
    static let baseURL = "https://isha.sadhguru.org/isha/api/videos?langcode=en&page=1&per_page=20"
}

enum HTTPMethodType: String {
    case POST = "POST"
    case GET = "GET"
}

class APIManager: NSObject {
    
    static let sharedService = APIManager()
    func requestAPI(url: String, parameter: [String: AnyObject]?, httpMethodType: HTTPMethodType, completion: @escaping (_ data: Data?, _ error: Error?) -> ()) {
        
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethodType.rawValue
        
        if parameter != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil,error)
                return
            }
            // check for http errors
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Error in fetching response")
            }
            completion(data,nil)
        }
        task.resume()
    }
    
}
