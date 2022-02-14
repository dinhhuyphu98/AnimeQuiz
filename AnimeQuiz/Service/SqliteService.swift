//
//  SqliteService.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 26/08/2021.
//

import UIKit
import SQLite

class SqliteService:NSObject {
    static let shared: SqliteService = SqliteService()
    var DatabaseRoot:Connection?
    var listData:[QuizModel] = [QuizModel]()
    func loadInit(){
        let dbURL = Bundle.main.url(forResource: "animequiz", withExtension: "db")!
        
        var newURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        newURL.appendPathComponent("animequiz.db")
        do {
            if FileManager.default.fileExists(atPath: newURL.path) {
                print("sss")
            }
            try FileManager.default.copyItem(atPath: dbURL.path, toPath: newURL.path)
            print(newURL.path)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            DatabaseRoot = try Connection(newURL.path)
        } catch {
            DatabaseRoot = nil
            let nserr = error as NSError
            print("Cannot connect to Database. Error is: \(nserr), \(nserr.userInfo)")
        }
    }
    
    func getData(closure: @escaping (_ response: [QuizModel]?, _ error: Error?) -> Void) {
        let users1 = Table("quiz")
        let Id1 = Expression<Int64>("Id")
        let question1 = Expression<String?>("question")
        let image1 = Expression<Blob?>("image")
        let A1 = Expression<String?>("A")
        let B1 = Expression<String?>("B")
        let C1 = Expression<String?>("C")
        let D1 = Expression<String?>("D")
        let values1 = Expression<String?>("values")
        listData.removeAll()
        if let DatabaseRoot = DatabaseRoot{
            do{
                for user in try DatabaseRoot.prepare(users1) {
                    listData.append(QuizModel(Id: Int(user[Id1])
                                              ,question:user[question1] ?? ""
                                              ,image: user[image1] ?? Blob(bytes: [0])
                                              ,A: user[A1] ?? ""
                                              ,B: user[B1] ?? ""
                                              ,C: user[C1] ?? ""
                                              ,D: user[D1] ?? ""
                                              ,values: user[values1] ?? "" ) )
                                              
                }
            } catch  {
            }
        }
        closure(listData, nil)
        
    }
}

