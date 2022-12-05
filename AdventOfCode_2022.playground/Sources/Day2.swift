import Foundation

enum RPC: Int {
    case rock = 1
    case paper  = 2
    case sissors = 3
    
    init?(_ value: String) {
        switch value {
        case "A", "X": self = .rock
        case "B", "Y": self = .paper
        case "C", "Z": self = .sissors
        default: return nil
        }
    }
    
    private func compare(m1:RPC) -> RoundOutcome{
        if m1 == self { return .draw }
        if self == .rock {
            return m1 == .sissors ? .won : .lost
        }
        if self == .paper {
            return m1 == .rock ? .won : .lost
        }
        if self == .sissors {
            return m1 == .paper ? .won : .lost
        }
        return .lost
    }
    
    func score(u1:RPC) -> Int{
        let moveVal = self.rawValue
        let outcome = compare(m1: u1)
        
        return moveVal + outcome.rawValue
    }
}

enum RoundOutcome: Int {
    case lost = 0
    case draw  = 3
    case won = 6
    
    init?(_ value: String) {
        switch value {
        case "X": self = .lost
        case "Y": self = .draw
        case "Z": self = .won
        default: return nil
        }
    }
    
    func reverse(u1:RPC) -> RPC{
        if self == .draw { return u1 }
        if self == .lost {
            return u1 == .rock ? .sissors : RPC(rawValue: u1.rawValue - 1)!
        }else{
            return u1 == .sissors ? .rock : RPC(rawValue: u1.rawValue + 1)!
        }
    }
}

public struct Day2 {

    public static func part1() {
        let text = Bundle.main.getInput(file: "input_day2")?.trimmingCharacters(in: .whitespaces)
        var result = 0
        if let rounds = text?.split(separator: "\n"){
            for round in rounds {
                let moves = round.split(separator: " ")
                if let u1 = RPC(String(moves[0])), let u2 = RPC(String(moves[1])){
                    result += u2.score(u1: u1)
                }
            }
        }
        print("\(result)")
    }
    
    public static func part2() {
        let text = Bundle.main.getInput(file: "input_day2")?.trimmingCharacters(in: .whitespaces)
        var result = 0
        if let rounds = text?.split(separator: "\n"){
            for round in rounds {
                let moves = round.split(separator: " ")
                if let u1 = RPC(String(moves[0])), let u2 = RoundOutcome(String(moves[1])){
                    result += u2.reverse(u1: u1).rawValue + u2.rawValue
                }
            }
        }
        print("\(result)")
    }
}
