import UIKit

let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=AKCB6aZVGnVrp6ianfDnZZoTgySEzS14I6FbBCvx")!

var urlComponents = URLComponents(string: "https://api.nasa.gov/planetary/apod")!
urlComponents.queryItems = [
    "api_key": "AKCB6aZVGnVrp6ianfDnZZoTgySEzS14I6FbBCvx",
    "date": "2013-07-16"
].map { URLQueryItem(name: $0.key, value: $0.value)}

Task {
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    let jsonDecoder = JSONDecoder()
    if let response = response as? HTTPURLResponse,
       response.statusCode == 200,
       let dictionary = try? jsonDecoder.decode([String: String].self, from: data) {
        print(dictionary)
        
    }
    
}
       

