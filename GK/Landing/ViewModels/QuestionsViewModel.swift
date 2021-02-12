//
//  QuestionsViewModel.swift
//  GK
//
//  Created by Oscar on 2021/02/12.
//

import Foundation

class QuestionsViewModel: NSObject {
    private var apiService: APIService!
    private(set) var questionsData : Questions! {
            didSet {
                self.bindQuestionsViewModelToController()
            }
        }
    
    var bindQuestionsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetQuestionData()
    }
    
    func callFuncToGetQuestionData() {
        self.apiService.apiToGetQuestionsData { (questionsData) in
            print(questionsData)
            self.questionsData = questionsData
        }
    }
}
