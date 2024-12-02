import Foundation

extension Bundle {
    func getInput(file:String) -> String? {
        do {
            guard let fileUrl = self.url(forResource: file, withExtension: "txt") else { fatalError() }
            let data = try Data(contentsOf: fileUrl)
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
        }
        return nil
    }
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
