import Foundation

public struct Day5 {

    public static func part1() -> Int{
        let text = Bundle.main.getInput(file: "input_day5")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
        
        let pageOrdering = lines.filter{ $0.contains("|") }
        let updates = lines.filter{ $0.contains(",") }
        
        var dicNext = [Int:[Int]]()
        
        for order in pageOrdering{
            let vals = order.split(separator: "|").map{ Int($0) }
            
            if var next = dicNext[vals[0]!]{
                next.append(vals[1]!)
                dicNext[vals[0]!] = next
            }else{
                dicNext[vals[0]!] = [vals[1]!]
            }
        }
        
        var counter = 0
        for update in updates {
            let pages = update.split(separator: ",").compactMap{ Int($0)! }
            var valid = true
            for (index, page) in pages.enumerated(){
                let pn = pages.split(separator: page)
                
                if index > 0, let before = pn[safe: 0]{
                    if let next = dicNext[page]{
                        if Set(next).intersection(Set(before)).count > 0{
                            valid = false
                            break
                        }
                    }
                }
            }
            if valid == false{
                continue
            }
            counter += pages[safe: pages.count/2] ?? 0
        }
        
        return counter
    }
    
    public static func part2() -> Int{
        let text = Bundle.main.getInput(file: "input_day5")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
        
        let pageOrdering = lines.filter{ $0.contains("|") }
        let updates = lines.filter{ $0.contains(",") }
        
        var dicNext = [Int:[Int]]()
        
        for order in pageOrdering{
            let vals = order.split(separator: "|").map{ Int($0) }
            
            if var next = dicNext[vals[0]!]{
                next.append(vals[1]!)
                dicNext[vals[0]!] = next
            }else{
                dicNext[vals[0]!] = [vals[1]!]
            }
        }
        
        var incorrectUpdates = [[Int]]()
        for update in updates {
            let pages = update.split(separator: ",").compactMap{ Int($0)! }
            var valid = true
            for (index, page) in pages.enumerated(){
                let pn = pages.split(separator: page)
                
                if index > 0, let before = pn[safe: 0]{
                    if let next = dicNext[page]{
                        if Set(next).intersection(Set(before)).count > 0{
                            valid = false
                            break
                        }
                    }
                }
            }
            if valid == false{
                incorrectUpdates.append(pages)
            }
        }
        
        var sum = 0
        for incorrectUpdate in incorrectUpdates {
            let sorted = incorrectUpdate.sorted {
                if let next = dicNext[$0]{
                    if Set(next).intersection(Set([$1])).count > 0{
                        return true
                    }
                }
                return false
            }
            sum += sorted[safe: sorted.count/2] ?? 0
        }
        
        return sum
    }
}
