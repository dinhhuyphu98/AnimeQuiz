//
//  GreatViewController.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 29/08/2021.
//

import UIKit

class GreatViewController: UIViewController {

    @IBOutlet weak var Trueaswer: UILabel!
    @IBOutlet weak var Image: UIImageView!
    var Data:[QuizModel] = [QuizModel]()
    var imageSend : UIImage = UIImage()
    var valuesSend : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        AdmobManager.shared.logEvent()
        self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
        
        SqliteService.shared.getData(){ repond,error in
            if let repond = repond{
                self.Data = repond
            }
        }
        self.Trueaswer.text = valuesSend
        self.Image.image = imageSend
        self.Image.layer.cornerRadius = 50
    }
    @IBAction func Nextgame(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeplayViewController") as! HomeplayViewController
//
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc, animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("SU_KIEN_THAY_DOI_DATA"), object: nil)

        self.dismiss(animated: true)
    }
    @IBAction func QC(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
