import Foundation

let input1 = """
{
    "pattern": "1",
    "names": [
        {
            "name" : "val"
        }
    ]
}
""".data(using: .utf8)!

let input2 = """
{
    {
    "pattern": "2",
    "names": [
        {
            "name" : 123
        }
    ]
}
""".data(using: .utf8)!

let patterns = [input1,input2]

struct Name: Codable {
    let name: String?
}

// Optionalじゃない
struct Define1: Codable {
    let pattern: String?
    let names: [Name]
}

// Optional
struct Define2: Codable {
    let pattern: String?
    let names: [Name]?
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
