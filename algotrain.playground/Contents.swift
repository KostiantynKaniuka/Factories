import UIKit

class Solution {
    func romanToInt(_ s: String) -> Int {
        var result = 0
        var output = 0
        var romanDictionary: [Character: Int] = ["I": 1, "V": 5, "X": 10, "L": 50,"C": 100, "D": 500, "M": 1000]
        for char in s {
            if let value = romanDictionary[char] {
                result += value
                if value > output {
                    result -= 2 * output
                    
                }
                output = value
                }
            }
       return result
        }
    }


Solution().romanToInt("IV")
