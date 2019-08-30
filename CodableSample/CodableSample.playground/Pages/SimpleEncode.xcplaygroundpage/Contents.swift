import Foundation

struct Landmark: Encodable {
    var name: String
    var buildYear: String
    var height: String
}

let hills = Landmark(name: "六本木ヒルズ", buildYear: "2003", height: "238")
let data = try! JSONEncoder().encode(hills)
print(String(data: data, encoding: .utf8)!) //{"name":"六本木ヒルズ","height":"238","buildYear":"2003"}



