//
//  Observable.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/01.
//

import Foundation

final class Observable<T> {
    typealias EventHandler = ((T) -> Void)? // 제네릭타입으로 들어와 반환하지 않는 함수
    
    struct Observer {
        var handler: EventHandler
    }
    
    var observers = [Observer]()
    
    var value: T {
        didSet {
            observers.forEach { observer in
                observer.handler?(value)
                // 값 변경 직후에 호출
                // 2. 값이 들어오면, 값 저장
            }
        }
    }
    
    // 1. 어딘가에서 Observable 인스턴스가 생성이 되면 Value의 값이 생성
    init(_ value: T) {
        self.value = value
    }
    
    // 어딘가에서 observable의 bind를 호출하면, Observars 안에 value 저장
    func bind(with eventHandler: @escaping (T) -> Void) {
        observers.append(Observer(handler: eventHandler))
    }
}
