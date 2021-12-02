//
//  QuestionView.swift
//  RabbleWabble
//
//  Created by todoc on 2021/12/02.
//

import UIKit
import SnapKit

final class QuestionView: UIView {
    lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = "Answer"
        label.font = UIFont.systemFont(ofSize: 48)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "prompt"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Hint"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var incorrectCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemRed
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    lazy var correctCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemGreen
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    lazy var redCircleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = ""
        button.setImage(UIImage(named: "ic_circle_x")!, for: .normal)
        return button
    }()
    
    lazy var greenCircleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = ""
        button.setImage(UIImage(named: "ic_circle_check")!, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init frame")
        backgroundColor = .white
        setAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutoLayout() {
        print("QuestionView SetAutoLayout")
        addSubview(promptLabel)
        promptLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(hintLabel)
        hintLabel.snp.makeConstraints { make in
            make.top.equalTo(promptLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(answerLabel)
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(hintLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        addSubview(redCircleButton)
        redCircleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
        }
        
        addSubview(incorrectCountLabel)
        incorrectCountLabel.snp.makeConstraints { make in
            make.top.equalTo(redCircleButton.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(24)
            make.centerX.equalTo(redCircleButton)
        }
        
        addSubview(greenCircleButton)
        greenCircleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(32)
        }
        
        addSubview(correctCountLabel)
        correctCountLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.top.equalTo(greenCircleButton.snp.bottom).offset(8)
            make.centerX.equalTo(greenCircleButton)
        }
    }
}
