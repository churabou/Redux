//
//  Subscription.swift
//  Redux
//
//  Created by ちゅーたつ on 2018/09/12.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

protocol AnyStoreSubscriber: class {
    func _newState(state: Any)
}

protocol StoreSubscriber: AnyStoreSubscriber {
    associatedtype StoreSubscriberStateType
    func newState(state: StoreSubscriberStateType)
}


// SubscriptionではAnyStoreSubscriberの_newStateを呼ぶだけ。
extension StoreSubscriber {
    public func _newState(state: Any) {
        if let typedState = state as? StoreSubscriberStateType {
            newState(state: typedState)
        }
    }
}

class Subscription<State> {
    
    weak var subscriber: AnyStoreSubscriber?
    
    init(subscriber: AnyStoreSubscriber) {
        self.subscriber = subscriber
    }
    
    func newValue(state: State) {
        subscriber?._newState(state: state as Any)
    }
}
