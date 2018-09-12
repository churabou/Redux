//
//  CounterView.swift
//  CounterExample
//
//  Created by ちゅーたつ on 2018/09/12.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

final class CounterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private (set) lazy var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .gray
        l.text = "tap + or -"
        l.font = .systemFont(ofSize: 20)
        l.textAlignment = .center
        return l
    }()
    
    private lazy var increaseButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("+", for: .normal)
        b.backgroundColor = .red
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(actionIncrease), for: .touchUpInside)
        return b
    }()
    
    private lazy var decreaseButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("-", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .blue
        b.addTarget(self, action: #selector(actionDecrease), for: .touchUpInside)
        return b
    }()
    
    func initializeView() {
        backgroundColor = .white
        addSubview(label)
        addSubview(increaseButton)
        addSubview(decreaseButton)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 300),
            label.heightAnchor.constraint(equalToConstant: 100),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            increaseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            increaseButton.heightAnchor.constraint(equalToConstant: 100),
            increaseButton.rightAnchor.constraint(equalTo: rightAnchor),
            increaseButton.topAnchor.constraint(equalTo: label.bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            decreaseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            decreaseButton.heightAnchor.constraint(equalToConstant: 100),
            decreaseButton.leftAnchor.constraint(equalTo: leftAnchor),
            decreaseButton.topAnchor.constraint(equalTo: label.bottomAnchor)
            ])
    }
    
    @objc private func actionIncrease() {
        AppStore.count.dispatch(action: .increase)
    }
    
    @objc private func actionDecrease() {
        AppStore.count.dispatch(action: .decrease)
    }
}
