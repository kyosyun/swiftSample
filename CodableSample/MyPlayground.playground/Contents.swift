import Foundation

struct Landmark: Decodable {
    var name: String
    var buildYear: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

let data = try! JSONEncoder().encode(Landmark(name: "六本木ヒルズ", buildYear: "2003"))
print(String(data: data, encoding: .utf8) ?? "")
