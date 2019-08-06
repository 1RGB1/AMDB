//
//  BaseNetwork.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/6/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

class BaseNetwork {
    
    func handleError(_ errorCode: Int) -> String {
        
        switch errorCode {
            case 0:
                return "Success"
            
            default:
                return ""
        }
    }
}
