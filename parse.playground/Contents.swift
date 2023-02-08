import UIKit
//
//let json1 = """
//{
//    "latitude": 44.4,
//    "longitude": 55.5,
//}
//"""
//
//struct Coordinate: Codable {
//    var latitude: Double
//    var longitude: Double
//}
//
//let data = json1.data(using: .utf8)!
//let result = try! JSONDecoder().decode(Coordinate.self, from: data)
//result.latitude


//let json2 = """
// {
//     "name": "Tatooine",
//     "foundingYear": 1977,
//     "location": {
//         "latitude": 44.4,
//         "longitude": 55.5,
//     },
// }
//"""
//
//struct Planet: Codable {
//    var name: String
//    var foundingYear: Int
//    var location: Coordinate
//
//    struct Coordinate: Codable {
//        let latitude: Double
//        let longitude: Double
//    }
//}
//
//let data1 = json2.data(using: .utf8)!
//let result2 = try! JSONDecoder().decode(Planet.self, from: data1)
//result2.location.latitude

let json3 = """
 {
     "planet_name": "Tatooine",
     "founding_year": 1977,
     "location": {
         "latitude": 44.4,
         "longitude": 55.5,
     },
 }
"""
struct AnotherPlanet: Codable {
    let planetName: String
    let foundingYear: Int
    let location: Location
    
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    enum CodingKeys: String,CodingKey {
        case planetName = "planet_name"
        case foundingYear = "founding_year"
        case location
    }
}

let data = json3.data(using: .utf8)!
let result = try! JSONDecoder().decode(AnotherPlanet.self, from: data)
result.location.longitude
result.foundingYear
