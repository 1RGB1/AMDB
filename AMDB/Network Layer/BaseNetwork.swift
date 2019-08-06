//
//  BaseNetwork.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//
//  This class intended to handle errors description according to errorCode but it already handled in APIs in property status_message
//  But in future work if we needed to handle other languages and if status_message is not returned in that language we will map it
//  using status_code

class BaseNetwork {
    
    func handleError(_ statusCode: Int) -> String {
        
        switch statusCode {
            case 0:
                return "Success"
            
            default:
                return "Opps, something went wrong"
        }
    }
}
