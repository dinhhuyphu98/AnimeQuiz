//
//  QuizModel.swift
//  AnimeQuiz
//
//  Created by ĐINH HUY PHU on 23/08/2021.
//

import Foundation
import SQLite.Swift

class QuizModel: NSObject {
    var Id : Int = 0
    var question : String = ""
    var image:Blob = Blob(bytes: [0])
    var A : String = ""
    var B : String = ""
    var C : String = ""
    var D : String = ""
    var values : String = ""
    
    init(Id: Int,question : String,image : Blob,A : String, B : String, C : String,D : String,values : String) {
        self.Id = Id
        self.question = question
        self.image = image
        self.A = A
        self.B = B
        self.C = C
        self.D = D
        self.values = values
    }
}
