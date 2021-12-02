//
//  ViewController.swift
//  RabbleWabble
//
//  Created by todoc on 2021/12/02.
//

import UIKit

public class QuestionViewController: UIViewController {
    lazy var questionView = QuestionView()
    
    // MARK: - Instance Properties
    var questionGroup = QuestionGroup.basicPhrases()
    // 화면에 나오는 현재 질문의 인덱스
    var questionIndex = 0
    
    // 정답 갯수
    var correctCount = 0
    // 오답 갯수
    var incorrectCount = 0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
        setEventHandler()
    }
    public override func loadView() {
        self.view = questionView
    }
    
    private func setEventHandler() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleAnswerLabels(_:)))
        questionView.addGestureRecognizer(tapGesture)
        questionView.greenCircleButton.addTarget(self,
                                                 action: #selector(handleCorrect(_:)),
                                                 for: .touchUpInside)
        questionView.redCircleButton.addTarget(self,
                                               action: #selector(handleIncorrect(_:)),
                                               for: .touchUpInside)
    }
    
    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
    }
    
    @objc func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden.toggle()
        questionView.hintLabel.isHidden.toggle()
    }
    
    @objc func handleCorrect(_ sender: Any) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    
    @objc func handleIncorrect(_ sender: Any) {
        incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else { return }
        showQuestion()
    }
}
