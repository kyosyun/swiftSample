import Foundation

let input1 = """
{
    "pattern": "1",
    "name": "val"
}
""".data(using: .utf8)!

let input2 = """
{
    "pattern": "2",
    "name": 123
}
""".data(using: .utf8)!

let input3 = """
{
    "pattern": "3",
    "name": null
}
""".data(using: .utf8)!

let input4 = """
{
    "pattern": "4"
}
""".data(using: .utf8)!

let input5 = """
{
}
""".data(using: .utf8)!

let patterns = [input1,input2, input3, input4, input5]

struct Define1: Codable {
    let pattern: String?
    let name: String
}

struct Define2: Codable {
    let pattern: String?
    let name: String = "def"
}

struct Define3: Codable {
    let pattern: String?
    let name: String?
}

struct Define4: Codable {
    let pattern: String?
    let name: String?
}

struct Define5: Codable {
    let pattern: String?
    var name: String
}

struct Define6: Codable {
    let pattern: String?
    var name: String = "def"
}

struct Define7: Codable {
    let pattern: String?
    var name: String?
}

struct Define8: Codable {
    let pattern: String?
    var name: String? = "def"
}

class Printer<T: Codable> {
    func printSample() {
        print("==== \(T.self) ====")
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
        print("")
    }
}

Printer<Define1>().printSample()
Printer<Define2>().printSample()
Printer<Define3>().printSample()
Printer<Define4>().printSample()
Printer<Define5>().printSample()
Printer<Define6>().printSample()
Printer<Define7>().printSample()
Printer<Define8>().printSample()
