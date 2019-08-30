import Foundation

struct Landmark: Encodable {
    var name: String
    var buildYear: String
    var height: String

    enum CodingKeys: String, CodingKey {
        case name
        // 1. CodingKeysとして指定したもののみencodeされる。
        // 2. CodingKeysで指定したrawValueでencodeされる。
        case height = "tall"
    }
}

let data = try! JSONEncoder().encode(Landmark(name: "六本木ヒルズ", buildYear: "2003", height: "238"))
print(String(data: data, encoding: .utf8) ?? "")
