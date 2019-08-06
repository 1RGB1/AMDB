//
//  Utilities.swift
//  AMDB
//
//  Created by Ahmad Ragab on 8/7/19.
//  Copyright © 2019 Ahmad Ragab. All rights reserved.
//

import Foundation
import SVProgressHUD

class Utilities {
    class func showProgressHUDWithSuccess(_ status: String) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            SVProgressHUD.showSuccess(withStatus: status)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            SVProgressHUD.dismiss()
        })
    }
    
    class func showProgressHUD() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            SVProgressHUD.show()
        })
    }
    
    class func showProgressHUDWithError(_ error: String) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            SVProgressHUD.showError(withStatus: error)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            SVProgressHUD.dismiss()
        })
    }
    
    class func dismissProgressHUD() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
