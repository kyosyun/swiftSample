import Foundation

let input1 = """
{
    "pattern": "input1",
    "name": "val"
}
""".data(using: .utf8)!

let input2 = """
{
    "pattern": "pattern2",
    "name": 123
}
""".data(using: .utf8)!
//
//
//let input3 = """
//{
//    "pattern": "val3",
//    "name": null
//}
//""".data(using: .utf8)!
//
//
//let input4 = """
//{
//    "pattern": "val4"
//}
//""".data(using: .utf8)!
//
//let input5 = """
//{
//}
//""".data(using: .utf8)!
//
let patterns = [val1,val2]

struct Define1: Codable {
    let pattern: String?
    let name: String
}

struct Define2: Codable {
    let pattern: String?
    let name: String = "def"
}

//struct Define3: Codable {
//    let pattern: String?
//    let name: String?
//}
class Printer<T: Codable> {
    func printSample() {
        print("")
        patterns.forEach { (data) in
            do {
                let res = try JSONDecoder().decode(T.self, from: data)
                print(res)
            } catch {
                if let error = error as? DecodingError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
Printer<Dog1>().printSample()

//let res = try JSONDecoder().decode(, from: val1)


//let encoded = try JSONEncoder().encode(res)
//print(String(data: encoded, encoding: .utf8)!)


//let structs: [Decodable] = [Dog1.self, Dog2.self]

//structs.forEach{ type in
//}
