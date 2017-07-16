//: Playground - noun: a place where people can play

import UIKit
import RxSwift

import XCPlayground
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

exampleOf(description: "just, of, from") { 
    
    let one = 1
    let two = 2
    let three = 3
    
    let observable: Observable<Int> = Observable<Int>.just(one)
    let observable2 = Observable.of(one, two, three)
    let observable3 = Observable.of([one, two, three])
    let observable4 = Observable.from([one, two, three])
}

// ********* //

exampleOf(description: "subscribe") { 
    
    let one = 1
    let two = 2
    let three = 3
    
    let obsevable = Observable.of(one, two, three)
    
    print("---- All events")
    obsevable.subscribe { event in
        print(event)
    }
    
    print("---- Get elements unwrap")
    obsevable.subscribe { event in
        if let element = event.element {
           print(element)
        }
    }
    
    print("---- Only elements")
    obsevable.subscribe(onNext: { element in
        print(element)
    })
    
}

// ********* //

exampleOf(description: "empty") { 
    
    let observable = Observable<Void>.empty()
    
    observable.subscribe(
    
        // 1
        onNext: { element in
            print(element)
        },
        
        // 2
        onCompleted: {
            print("completed")
        }
        
    )
}

// ********* //

exampleOf(description: "never") { 
    
    let observable = Observable<Any>.never()
    
    observable.subscribe(
    
        // 1
        onNext: { element in
            print(element)
        },
        
        // 2
        onCompleted: {
            print("completed")
        }
    )
}

// ********* //

exampleOf(description: "range") { 
    
    let observable = Observable<Int>.range(start: 1, count: 10)
    
    observable.subscribe(onNext: { i in
        print(i)
    })
}

// ********* //

exampleOf(description: "dispose") {
    
    // 1
    let observable = Observable.of("A", "B", "C")
    // 2
    let subscription = observable.subscribe { event in
        // 3
        print(event)
    }
    
    subscription.dispose()
}

// ********* //

exampleOf(description: "DisposeBag") { 
    
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C")
        .subscribe {
            print($0)
        }
        .addDisposableTo(disposeBag)
    
}

// ********* //

exampleOf(description: "create_1") {
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        
        observer.onNext("1")
        
        observer.onCompleted()
        
        observer.onNext("?")
        
        return Disposables.create()
        }
        .subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
        )
        .addDisposableTo(disposeBag)
    
}


enum MyError: Error {
    case anError
}


exampleOf(description: "create_2") {
    
    enum MyError: Error {
        case anError
    }
    
    let disposeBag = DisposeBag()
    
    Observable<String>.create { observer in
        // 1
        observer.onNext("1")
        //    observer.onError(MyError.anError)
        // 2
            observer.onCompleted()
        // 3
        observer.onNext("?")
        // 4
        return Disposables.create()
        }
        .subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
    )
    //  .addDisposableTo(disposeBag)
    
}





























