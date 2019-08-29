import Foundation

let data = """
{
    "name": "bike",
    "maxSpeed": 180
}
""".data(using: .utf8)!

protocol Vhicle: Codable {

}

extension Vhicle {
    // default の実装。
    var apiKey: String {
        get{
            return "test"
        }
    }
}

struct Bike: Vhicle {
    let name: String
    let maxSpeed: Int?
}

let res = try JSONDecoder().decode(Bike.self, from: data)

// デフォルト利用されない。
String(data: try JSONEncoder().encode(Bike(name: "aaa", maxSpeed: 180)), encoding: .utf8)

// デフォルト利用されない
let bike = Bike(name: "aaaaa", maxSpeed: 180)
print(bike.name)
