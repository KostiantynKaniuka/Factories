import UIKit

func removeParenthesesContent(from string: String) -> String {
    return string.replacingOccurrences(of: "\\(.*?\\)", with: "", options: .regularExpression)
}

let string1 = "Very small (Up to 200l)"
let string2 = "Small (Up to 200l - 300l)"
let string3 = "Medium (300l - 500l)"

let result1 = removeParenthesesContent(from: string1) // "Very small "
let result2 = removeParenthesesContent(from: string2) // "Small "
let result3 = removeParenthesesContent(from: string3) // "Medium "
