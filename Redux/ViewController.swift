//
//  ViewController.swift
//  Redux
//
//  Created by ちゅーたつ on 2018/09/11.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

protocol ActionType {}

protocol StateType {
    static func initialState() -> Self
}


typealias Reducer<Action, State> = (_ action: Action, _ state: State) -> State


struct CountorState: StateType {
    var count: Int
    
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

class Store<Action, State> {

    var state: State {
        didSet {
            
        }
    }

    var reducer: Reducer<Action, State>
    
    init(state: State, reducer: @escaping Reducer<Action, State>) {
        self.state = state
        self.reducer = reducer
    }
    
    func dispatch(action: Action) {
        let newState = reducer(action, state)
        state = newState
    }
    
    
//    typealias SubscriptionType = StoreSubscriber<State>
//    var subscriptions: [SubscriptionType] = []

    func subscribe<S: StoreSubscriber>(_ subscriber: S) where S.StoreSubscriberStateType == StateType {
        
    }
}

protocol StoreSubscriber {
    associatedtype StoreSubscriberStateType
    func newState(state: StoreSubscriberStateType)
}

//
//extension Store where State: StateType {
//    convenience init(s: State.Type, reducer: @escaping Reducer<Action, State>) {
//        self.state = s.initialState()
//    }
//}


let store = Store<CountorAction, CountorState>(
    state: CountorState.initialState(),
    reducer: counterReducer
)
