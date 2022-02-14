//
//  HomeplayViewController.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 23/08/2021.
//

import UIKit
import SQLite.Swift
import GoogleMobileAds
import AppTrackingTransparency
import SwiftKeychainWrapper

class HomeplayViewController: UIViewController {
    
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var imagegame: UIImageView!
    @IBOutlet weak var answer0: UIButton!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var Levelgame1: UILabel!
    @IBOutlet weak var Money: UILabel!
    var Data:[QuizModel] = [QuizModel]()
    var level:String = ""
    var DaA : String = ""
    var DaB : String = ""
    var DaC : String = ""
    var DaD : String = ""
    var question : String = ""
    var values : String = ""
    var UrlImage : Blob = Blob(bytes: [0])
    var numbermoney : Int = 100
    var levelOk = 0
    var A : String = "A"
    var B : String = "B"
    var C : String = "C"
    var D : String = "D"
    
    @IBAction func submitAnswer0(_ sender: Any) {
        checkAnswer(idx: "A")
    }
    
    @IBAction func submitAnswer1(_ sender: Any) {
        checkAnswer(idx: "B")
    }
    
    @IBAction func submitAnswer2(_ sender: Any) {
        checkAnswer(idx: "C")
    }
    
    @IBAction func submitAnswer3(_ sender: Any) {
        checkAnswer(idx: "D")
    }
    
    func Loai() {
        if A == values {
            answer0.isHidden = false
            answer1.isHidden = false
            answer2.isHidden = true
            answer3.isHidden = true
        }
        if B == values {
            answer0.isHidden = true
            answer1.isHidden = false
            answer2.isHidden = false
            answer3.isHidden = true
        }
        if C == values {
            answer0.isHidden = false
            answer1.isHidden = true
            answer2.isHidden = false
            answer3.isHidden = true
        }
        if D == values {
            answer0.isHidden = false
            answer1.isHidden = true
            answer2.isHidden = true
            answer3.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let retrieved: Int = KeychainWrapper.standard.integer(forKey: "money"){
            numbermoney = retrieved
            Money.text = "\(numbermoney)"
        }
        if let levelSelected: Int = KeychainWrapper.standard.integer(forKey: "LEVEL_SELECT"){
            levelOk = levelSelected
        }
        setQuestions()
    }
    
    func setQuestions() {
        Levelgame1.text = "level " + String(levelOk+1)
        self.level = "\(Data[levelOk].Id)"
        self.DaA = Data[levelOk].A
        self.DaB = Data[levelOk].B
        self.DaC = Data[levelOk].C
        self.DaD = Data[levelOk].D
        self.values = Data[levelOk].values
        
        self.question = Data[levelOk].question
        self.UrlImage = Data[levelOk].image
        self.Money.text = "\(numbermoney)"
        questionlabel.text = question
        answer0.setTitle(DaA, for: .normal)
        answer1.setTitle(DaB, for: .normal)
        answer2.setTitle(DaC, for: .normal)
        answer3.setTitle(DaD, for: .normal)
        
        answer0.setTitleColor(.yellow, for: .normal)
        answer1.setTitleColor(.yellow, for: .normal)
        answer2.setTitleColor(.yellow, for: .normal)
        answer3.setTitleColor(.yellow, for: .normal)
        
        answer0.titleLabel!.font = UIFont(name: "PortLligatSans-Regular", size: 23)
        answer1.titleLabel!.font = UIFont(name: "PortLligatSans-Regular", size: 23)
        answer2.titleLabel!.font = UIFont(name: "PortLligatSans-Regular", size: 23)
        answer3.titleLabel!.font = UIFont(name: "PortLligatSans-Regular", size: 23)
        
        
        let data = NSData(bytes:  UrlImage.bytes,
                          length: UrlImage.bytes.count)
        if let image = UIImage(data: data as Data){
            imagegame.image = image
        }
        imagegame.layer.cornerRadius = 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        AdmobManager.shared.logEvent()
        //        self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReloadDataAll(notification:)), name: Notification.Name("SU_KIEN_THAY_DOI_DATA"), object: nil)
        
    }
    
    @objc func ReloadDataAll(notification: Notification) {
        if let retrieved: Int = KeychainWrapper.standard.integer(forKey: "money"){
            numbermoney = retrieved
            Money.text = "\(numbermoney)"
        }
        if let levelSelected: Int = KeychainWrapper.standard.integer(forKey: "LEVEL_SELECT"){
            levelOk = levelSelected
        }
        self.loadView()
        setQuestions()
    }
    
    func checkAnswer(idx: String) {
        if ( values == idx) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GreatViewController") as! GreatViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.imageSend = imagegame.image ?? UIImage()
            vc.valuesSend = values
            KeychainWrapper.standard.set( levelOk + 1, forKey: "LEVEL_SELECT")
            present(vc, animated: true, completion: nil)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WrongViewController") as! WrongViewController
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnloaicau(_ sender: Any) {
        if numbermoney > 0 {
            numbermoney = numbermoney - 50
            Money.text = "\(numbermoney)"
            KeychainWrapper.standard.set(numbermoney, forKey: "money")
            Loai()
        }
        else {
            print("Không đủ tiền")
        }
    }
    @IBAction func btnQC(_ sender: Any) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                AdmobManager.shared.createAndLoadInterstitial()
            })
        } else {
            AdmobManager.shared.createAndLoadInterstitial()
        }
        numbermoney = numbermoney + 100
        Money.text = "\(numbermoney)"
        KeychainWrapper.standard.set(numbermoney, forKey: "money")
        
    }
}
