//
//  PaymentManager.swift
//  MasterCleaner
//
//  Created by Nhuom Tang on 7/15/19.
//  Copyright © 2019 Nhuom Tang. All rights reserved.
//

import UIKit

class PaymentManager: NSObject {
   
    static let shared = PaymentManager()
    
    func isPurchase()->Bool{
        if UserDefaults.standard.bool(forKey: "isPurchase"){
            return true
        }
        return false
    }
    
    func savePurchase(){
        UserDefaults.standard.setValue(true, forKey: "isPurchase")
    }
    
}

