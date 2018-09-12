//
//  ViewController.swift
//  Redux
//
//  Created by ちゅーたつ on 2018/09/11.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

struct CountorState {
    var count: Int
}

extension CountorState: StateType {
    static func initialState() -> CountorState {
        return CountorState(count: 0)
    }
}

enum CountorAction: ActionType {
    case increase
    case decrease
}

func counterReducer(_ action: CountorAction, _ state: CountorState) -> CountorState {
    var newState = state
    switch action {
    case .increase:
        newState.count += 1
    case .decrease:
        newState.count -= 1
    }
    return newState
}

struct AppStore {
    static let count = Store<CountorAction, CountorState>(
        state: CountorState.initialState(),
        reducer: counterReducer
    )
}

final class CountorViewController: UIViewController, StoreSubscriber {
    
    typealias StoreSubscriberStateType = CountorState
    
    private var baseView = CounterView()
    private var label: UILabel { return baseView.label }
    
    override func loadView() {
        view = baseView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewWillDisappear(animated)
        AppStore.count.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppStore.count.unsubscribe(self)
    }
    
    func newState(state: CountorState) {
        label.text = "count: \(state.count)"
    }
}
