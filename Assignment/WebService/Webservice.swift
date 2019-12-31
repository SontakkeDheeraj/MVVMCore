//
//  Webservice.swift
//  Assignment
//
//  Created by Prakash Sabale on 30/12/19.
//  Copyright © 2019 Orangebit. All rights reserved.
//

import Foundation
struct Webservice {
    
    static func getAllListObjects(callback: @escaping (Response?,  Error?) -> ()) {
        APIManager.sharedService.requestAPI(url: WebServiceConstants.baseURL, parameter: nil, httpMethodType: .GET) { (response, error) in
            if let data = response {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Response.self, from: data)
                    callback(result, nil)
                }catch {
                    print(error.localizedDescription)
                }
            } else {
                callback(nil, error)
            }
        }
    }
}
