//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by todoc on 2021/12/02.
//

import UIKit

/// 모든 Group을 보여주고 선택할 수 있는 tableView를 가진 View Controller
class SelectQuestionGroupViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        return tv
    }(){
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    // 데이터 모델
    let questionGroups = QuestionGroup.allGroups()
    // 선택한 QuestionGroup, 이 ViewController가 생성되는 초기에는 이 프로퍼티값이 비어있지만
    // 화면에 보여질때는 프로퍼티 값에 무조건 있을것이기에 ! 사용
    private var selectedQuestionGroup: QuestionGroup!
}


extension SelectQuestionGroupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
