import Foundation

final class Observable<T> {
    typealias EventHandler = ((T) -> Void)?

    struct Observer {
        var handler: EventHandler
    }
    
    var observers = [Observer]()
    
    var value: T {
        didSet {
            observers.forEach { observer in
                observer.handler?(value)
            }
        }
    }

    init(_ value: T) {
        self.value = value
    }
    
    func bind(with eventHandler: @escaping (T) -> Void) {
        observers.append(Observer(handler: eventHandler))
        eventHandler(value)
    }
}
