//
//  Reducer.swift
//  Redux
//
//  Created by ちゅーたつ on 2018/09/12.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import Foundation

typealias Reducer<Action, State> = (_ action: Action, _ state: State) -> State
