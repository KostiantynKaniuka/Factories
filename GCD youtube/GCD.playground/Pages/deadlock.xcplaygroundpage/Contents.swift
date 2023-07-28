import UIKit

class Queque1 {
     let serialQueque = DispatchQueue(label: "serialTest")
    private let concurrentQueque = DispatchQueue(label: "concurentQueqe", attributes: .concurrent)
}

class Queque2 {
    private let globalQueque = DispatchQueue.global()
    private let mainQueque  = DispatchQueue.main
}

let queque = Queque1()

queque.serialQueque.async {// deadlock
    print("async")
    queque.serialQueque.sync {
        print("as")
    }
    print("ok")
}
