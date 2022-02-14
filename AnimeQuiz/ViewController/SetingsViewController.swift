//
//  SetingsViewController.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 26/08/2021.
//

import UIKit
import SwiftKeychainWrapper
class SetingsViewController: UIViewController {
    var homeDelegate = MainViewController()
    var stasus : Bool = true

    override func viewDidLoad() {
         super.viewDidLoad()
        AdmobManager.shared.logEvent()
        self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
        if let music: Bool = KeychainWrapper.standard.bool(forKey: "MUSIC"){
            stasus = music
        }

     }
    @IBAction func Backmain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Playmp3(_ sender: Any) {
        
        if stasus == true {
            homeDelegate.player?.stop()
            stasus = false
            KeychainWrapper.standard.set(stasus, forKey: "MUSIC")
        }
        else {
            homeDelegate.player?.play()
            stasus = true
            KeychainWrapper.standard.set(stasus, forKey: "MUSIC")
        }
        
}
}
