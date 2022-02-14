//
//  LevelViewController.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 23/08/2021.
//

import UIKit
import SwiftKeychainWrapper

class LevelViewController: UIViewController {
    
    @IBOutlet weak var LevelcollectionView:UICollectionView!
    var Data:[QuizModel] = [QuizModel]()
    var indextNext : Int = 0
    var levelOk = 0
    
    @IBOutlet weak var LevelDone: UILabel!
        override func viewDidLoad() {
        super.viewDidLoad()
        LevelcollectionView.register(UINib(nibName: LevelCLVCell.className, bundle: nil), forCellWithReuseIdentifier: LevelCLVCell.className)
        
        if let levelSelected: Int = KeychainWrapper.standard.integer(forKey: "LEVEL_SELECT"){
            levelOk = levelSelected
        }
        SqliteService.shared.getData(){ repond,error in
            if let repond = repond{
                self.Data = repond
                self.LevelcollectionView.reloadData()
               
            }
            self.LevelDone.text = "\(self.levelOk + 1)" + "/\(self.Data.count)"
        }
//        AdmobManager.shared.logEvent()
//        self.view.addSubview(AdmobManager.shared.createBannerView(inVC: self))
    }
    @IBAction func Backmain(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension LevelViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == levelOk{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeplayViewController") as! HomeplayViewController
            vc.modalPresentationStyle = .fullScreen
            vc.Data = self.Data
    //        vc.level = "\(Data[indexPath.row + indextNext].Id)"
    //        vc.DaA = Data[indexPath.row + indextNext].A
    //        vc.DaB = Data[indexPath.row + indextNext].B
    //        vc.DaC = Data[indexPath.row + indextNext].C
    //        vc.DaD = Data[indexPath.row + indextNext].D
    //        vc.values = Data[indexPath.row + indextNext].values
    //
    //        vc.question = Data[indexPath.row + indextNext].question
    //        vc.UrlImage = Data[indexPath.row + indextNext].image

            vc.levelOk = indexPath.row
            self.present(vc, animated: true, completion: nil)
        }
        else if indexPath.row < levelOk{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeplayViewController") as! HomeplayViewController
            vc.modalPresentationStyle = .fullScreen
            vc.Data = self.Data
            vc.levelOk = indexPath.row
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCLVCell.className, for: indexPath) as! LevelCLVCell
        if indexPath.row < levelOk{
            cell.statusgame.image = #imageLiteral(resourceName: "Group 61")
        }
        else if indexPath.row == levelOk {
            cell.statusgame.image = nil
        }
        else{
            cell.statusgame.image = #imageLiteral(resourceName: "Group 60")
        }
        
        if self.Data.count > indexPath.row{
            let levelnumber = "\(Data[indexPath.row].Id)"
            cell.levelgame.text = levelnumber
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        return UICollectionReusableView()
    }
}

extension LevelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/4, height: collectionViewSize/4)
    }
    
}

