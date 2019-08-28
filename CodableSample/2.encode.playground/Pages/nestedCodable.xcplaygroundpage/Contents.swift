import Foundation

struct Landmark: Encodable {
    var name: String
    var height: String
    // 構造体でNestするケース
    var aditionalInfo: AditionalInfo

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
}

struct AditionalInfo: Encodable {
    var buildYear: String
}

let data = try! JSONEncoder().encode(Landmark(name: "六本木ヒルズ", height: "238", aditionalInfo: AditionalInfo(buildYear: "2003")))
print(String(data: data, encoding: .utf8) ?? "")


