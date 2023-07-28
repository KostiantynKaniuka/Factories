import UIKit
import PlaygroundSupport

var counter = 1
DispatchQueue.main.async {
    for i in 1...3 {
        counter = i
        print("\(counter)")
    }
}


for i in 4...6 {
    counter = i
    print("\(counter)")
}


DispatchQueue.main.async {
    counter = 9
    print("\(counter)")
}
