import Foundation

struct Landmark: Decodable {
    let name: String
    let buildYear: Int
    let landmarkType: LandmarkType // ① enumにも対応
    let additionalInfo: AdditionalInfo? // ② nest出来る
    private let typeName: String? = "landmark"

    struct AdditionalInfo: Decodable {

    }
}

enum LandmarkType: String, Codable {
    case building
    case park = "公園"
}

let hillsData = """
{"name":"六本木ヒルズ","buildYear": 2003, "landmarkType": "building"}
""".data(using: .utf8)!

let imperialData = """
{"name":"皇居","buildYear": 1869, "landmarkType": "公園"}
""".data(using: .utf8)!


let hills = try! JSONDecoder().decode(Landmark.self, from: hillsData)
let imperialPalace = try! JSONDecoder().decode(Landmark.self, from: imperialData)
print(hills) // Landmark(name: "六本木ヒルズ", buildYear: 2003, landmarkType: __lldb_expr_29.LandmarkType.building)
print(imperialPalace) // Landmark(name: "皇居", buildYear: 1869, landmarkType: __lldb_expr_29.LandmarkType.park)





