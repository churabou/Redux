//
//  Store.swift
//  Redux
//
//  Created by ちゅーたつ on 2018/09/12.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

class Store<Action, State> {
    
    private (set) var state: State {
        didSet {
            subscriptions.forEach {
                $0.newValue(state: state)
            }
        }
    }

    private var reducer: Reducer<Action, State>
    
    init(state: State, reducer: @escaping Reducer<Action, State>) {
        self.state = state
        self.reducer = reducer
    }
    
    func dispatch(action: Action) {
        let newState = reducer(action, state)
        state = newState
    }
    
    private var subscriptions: [Subscription<State>] = []
    // すぐ間違えるし忘れちゃうのでメモする
    // S.StoreSubscriberStateType == StateType にしたら Generic parameter S could not be inferredになる。
    func subscribe<S: StoreSubscriber>(_ subscriber: S) where S.StoreSubscriberStateType: StateType {
        subscriptions.append(Subscription(subscriber: subscriber))
    }
    
    func unsubscribe(_ subscriber: AnyStoreSubscriber) {
        if let index = subscriptions.index(where: { $0.subscriber === subscriber }) {
            subscriptions.remove(at: index)
        }
    }
}

