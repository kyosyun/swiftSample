import Foundation

struct Landmark: Encodable {
    let name: String
    let buildYear: String
    let height: String
    private let type: String? = "landmark"
}

let hills = Landmark(name: "六本木ヒルズ", buildYear: "2003", height: "238")
let data = try! JSONEncoder().encode(hills)
print(String(data: data, encoding: .utf8)!) //{"name":"六本木ヒルズ","height":"238","buildYear":"2003"}



