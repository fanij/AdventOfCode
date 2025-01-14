import XCTest

public class AdventOfCodeTests: XCTestCase {
    
    func testDay1() {
        XCTAssertEqual(Day1.part1(), 11)
        XCTAssertEqual(Day1.part2(), 31)
    }
    
    func testDay2() {
        XCTAssertEqual(Day2.part1(), 2)
        XCTAssertEqual(Day2.part2(), 4)
    }
    
    func testDay3() {
        XCTAssertEqual(Day3.part1(), 161)
        XCTAssertEqual(Day3.part2(), 48)
    }
    
    func testDay4() {
        XCTAssertEqual(Day4.part1(), 18)
        XCTAssertEqual(Day4.part2(), 9)
    }
    
    func testDay5() {
        XCTAssertEqual(Day5.part1(), 143)
        XCTAssertEqual(Day5.part2(), 123)
    }
    
    func testDay6() {
        XCTAssertEqual(Day6.part1(), 41)
        XCTAssertEqual(Day6.part2(), 6)
    }
    
    func testDay7() {
        XCTAssertEqual(Day7.part1(), 3749)
        XCTAssertEqual(Day7.part2(), 11387)
    }
    
    func testDay8() {
        XCTAssertEqual(Day8.part1(), 14)
        XCTAssertEqual(Day8.part2(), 34)
    }
    
    func testDay9() {
        XCTAssertEqual(Day9.part1(), 1928)
        XCTAssertEqual(Day9.part2(), 2858)
    }
    
    func testDay10() {
        XCTAssertEqual(Day10.part1(), 36)
        XCTAssertEqual(Day10.part2(), 81)
    }
    
    func testDay11() {
        XCTAssertEqual(Day11.part1(), 55312)
        XCTAssertEqual(Day11.part2(), 65601038650482)
    }
    
    func testDay12() {
        XCTAssertEqual(Day12.part1(), 1930)
    }
}
