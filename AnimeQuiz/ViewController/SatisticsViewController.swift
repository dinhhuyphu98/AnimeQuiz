//
//  SatisticsViewController.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 26/08/2021.
//

import UIKit

class SatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AdmobManager.shared.logEvent()
        self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Backmain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
