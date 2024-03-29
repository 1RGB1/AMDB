//
//  NetworkManager.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    // MARK: - Static fuunctions
    class func performNetworkActivityWithURL(_ url: String,
                                              Parameters params: [String : AnyHashable],
                                              HTTPMethod method: HTTPMethod,
                                              andCompletionHandler completion: @escaping(_ response: DataResponse<Any>) -> ()) {
        
        if let requestURL = URL(string: url) {
            Alamofire.request(requestURL, method: method, parameters: params).responseJSON { (response) in
                completion(response)
            }
        }
    }
}
