import Foundation

class Point: NSObject, NSCopying {
    var x:Int
    var y:Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? Point {
            return self.x == other.x && self.y == other.y
        } else {
            return false
        }
    }
    
    override var hash: Int {
        return "\(self.x) - \(self.y)".hashValue
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Point(x: x, y: y)
        return copy
    }
    
    override var description : String {
        return "(\(x),\(y))"
    }
}
