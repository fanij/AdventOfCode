import Foundation

public struct Day2 {

    public static func part1() -> Int{
        let text = Bundle.main.getInput(file: "input_day2")?.trimmingCharacters(in: .whitespaces)
        let values = text?.split(separator: "\n")
            .map{
                let values = ($0).split(separator: " ").map{ Int($0)! }
                return values
            }
         
        var valid = 0
        for v in values ?? []{
            let sign = v[1] - v[0] > 0 ? 1 : -1
            if validLevels(v: v, sign: sign){
                valid += 1
            }
        }
            
        return valid
    }
    
    public static func part2() -> Int{
        let text = Bundle.main.getInput(file: "input_day2")?.trimmingCharacters(in: .whitespaces)
        let values = text?.split(separator: "\n")
            .map{
                let values = ($0).split(separator: " ").map{ Int($0)! }
                return values
            }
         
        var valid = 0
        for v in values ?? []{
            let sign = v[1] - v[0] > 0 ? 1 : -1
            
            let badLevels = v.indices.dropLast().compactMap {
                let diff = v[$0 + 1] - v[$0]
                if isValidLevel(diff: diff, sign:sign) == false {
                    return $0 == 1 ? [0, Int($0), Int($0 + 1)] : [Int($0), Int($0 + 1)]
                }else{
                    return nil
                }
            }
            .reduce([], { (result: [Int], element: [Int]) -> [Int] in
                return result + element
            })
            
            if badLevels.count == 0{
                valid += 1
                continue
            }
            
            for bl in badLevels{
                var cv = v
                cv.remove(at: bl)
                let sign = cv[1] - cv[0] > 0 ? 1 : -1
                if validLevels(v: cv, sign: sign){
                    valid += 1
                    break
                }
            }
        }
            
        return valid
    }
    
    static func isValidLevel(diff:Int, sign:Int) -> Bool{
        abs(diff) > 0 && abs(diff) < 4 && (diff/abs(diff) * sign == 1) ? true : false
    }
    
    static func validLevels(v:[Int], sign:Int) -> Bool{
        let passed = v.indices.dropLast().compactMap {
            let diff = v[$0 + 1] - v[$0]
            if isValidLevel(diff: diff, sign: sign){
                return v[$0]
            }else{
                return nil
            }
        }
        
        if passed.count + 1 == v.count{
            return true
        }
        return false
    }
}
