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
        case aditionalInfo
    }
    enum AditionalInfoCodingKeys: String, CodingKey {
        case buildYear
    }


    // 3. データ構造がencodeの構造と異なるときは、自ら実装する必要がある
    func encode(to ecoder: Encoder) throws {
        var container = ecoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(height, forKey: .height)
        // nestする場合
        var nestedContainer = container.nestedContainer(keyedBy: AditionalInfoCodingKeys.self, forKey: .aditionalInfo)
        try nestedContainer.encode(buildYear, forKey: .buildYear)
    }
}

let data = try! JSONEncoder().encode(Landmark(name: "六本木ヒルズ", buildYear: "2003", height: "238"))
print(String(data: data, encoding: .utf8) ?? "")


