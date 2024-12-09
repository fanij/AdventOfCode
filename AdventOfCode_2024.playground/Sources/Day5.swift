import Foundation

public struct Day5 {

    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day5")?.trimmingCharacters(in: .whitespaces)
        let lines = text!.split(separator: "\n")
        
        let pageOrdering = lines.filter{ $0.contains("|") }
        let updates = lines.filter{ $0.contains(",") }
        
        var dicPrev = [Int:[Int]]()
        var dicNext = [Int:[Int]]()
        
        for order in pageOrdering{
            let vals = order.split(separator: "|").map{ Int($0) }
            
            if var next = dicNext[vals[0]!]{
                next.append(vals[1]!)
                dicNext[vals[0]!] = next
            }else{
                dicNext[vals[0]!] = [vals[1]!]
            }
            
            if var prev = dicPrev[vals[1]!]{
                prev.append(vals[0]!)
                dicPrev[vals[1]!] = prev
            }else{
                dicPrev[vals[1]!] = [vals[0]!]
            }
        }
        
        var counter = 0
        for update in updates {
            let pages = update.split(separator: ",").compactMap{ Int($0)! }
            var valid = true
            for (index, page) in pages.enumerated(){
                let pn = update.split(separator: "\(page)")
                
                if index > 0, let b = pn[safe: 0]{
                    let before = b.split(separator: ",").map{ Int($0)! }
                    if let next = dicNext[page]{
                        if Set(next).intersection(Set(before)).count > 0{
                            valid = false
                            break
                        }
                    }
                }
                if let a = pn[safe: 1]{
                    let after = a.split(separator: ",").map{ Int($0)! }
                    if let prev = dicPrev[page]{
                        if Set(prev).intersection(Set(after)).count > 0{
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
        
        print("counter: \(counter)")
    }
    
}
