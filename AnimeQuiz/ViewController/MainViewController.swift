//
//  MainViewController.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 22/08/2021.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import AppTrackingTransparency
class MainViewController: UIViewController {
    @IBOutlet weak var Setting: UIButton!
    @IBOutlet weak var Satistics: UIButton!
    @IBOutlet weak var Play: UIButton!
    var player : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        playerInit()
//            if player != nil {
//
//                player?.numberOfLoops = -1
//                player.play()
//            }
        AdmobManager.shared.fullRootViewController = self
                if #available(iOS 14, *) {
                    ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                        AdmobManager.shared.createAndLoadInterstitial()
                    })
                } else {
                    AdmobManager.shared.createAndLoadInterstitial()
                }
        AdmobManager.shared.logEvent()
        self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))

    }
    @IBAction func Playgame(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelViewController") as! LevelViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func Setting(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SetingsViewController") as! SetingsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.homeDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func Satistics(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SatisticsViewController") as! SatisticsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func playerInit() {
        
      guard let url = Bundle.main.url(forResource: "Nhac", withExtension: "mp3") else {
                    return
                }
                do {
                    player = try AVAudioPlayer(contentsOf: url)
                } catch let err {
                    print(err.localizedDescription)
                }
    }

}

