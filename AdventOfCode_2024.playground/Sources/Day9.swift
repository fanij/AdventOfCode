import Foundation

public struct Day9 {
    
    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day9")?.trimmingCharacters(in: .whitespaces)
        let line = text!.split(separator: "\n").map{ String($0) }.first!
        var diskMap = Array(line)
        var sum = 0
        
        var frontIndex = 0
        var backIndex = diskMap.count % 2 == 0 ? diskMap.count-2 : diskMap.count-1
        
        for i in 0..<diskMap.count{
            if i % 2 != 0{
                
                // free space
                var space = Int("\(diskMap[i])") ?? 0
                
                if space > 0 {
                    repeat{
                        var value = Int("\(diskMap[backIndex])") ?? 0
                        
                        if value > 0 {
                            sum += frontIndex * Int(backIndex/2)
                            
                            value -= 1
                            diskMap[backIndex] = Array("\(value)").first!
                            space -= 1
                            diskMap[i] = Array("\(space)").first!
                            
                            frontIndex += 1
                        }else{
                            if backIndex > 2 {
                                backIndex -= 2
                            }else{
                                break
                            }
                            
                            if i > backIndex {
                                continue
                            }
                        }
                    }while space > 0
                }
            }else{
                // data
                let value = Int("\(diskMap[i])") ?? 0
                diskMap[i] = "0"
                for _ in 0..<value{
                    sum += frontIndex * Int(i/2)
                    frontIndex += 1
                }
            }
        }
        print(sum)
    }
}
