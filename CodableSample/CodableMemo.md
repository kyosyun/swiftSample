# Codable の良いところ
## CodableObject -> data が簡単
```
import Foundation

struct Landmark: Encodable {
    var name: String
    var buildYear: String
    var height: String
}

let hills = Landmark(name: "六本木ヒルズ", buildYear: "2003", height: "238")
let data = try! JSONEncoder().encode(hills)
print(String(data: data, encoding: .utf8)!) //{"name":"六本木ヒルズ","height":"238","buildYear":"2003"}
```
## data -> CodableObject が簡単
```
import Foundation

struct Landmark: Decodable {
    var name: String
    var buildYear: String
    var height: String
}

let data = """
{"name":"六本木ヒルズ","height":"238","buildYear":"2003"}
""".data(using: .utf8)!

let hills = try! JSONDecoder().decode(Landmark.self, from: data)
print(hills) // Landmark(name: "六本木ヒルズ", buildYear: "2003", height: "238")
```

# Codable のイケていないところ
- 継承した際に、継承元・継承先ともに、encode / decode処理を書かないと行けない。
- protocol
