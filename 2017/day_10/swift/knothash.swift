//
//  knothash.swift
//  Advent of Code 2017
//
//  Created by Nicolas Bettenburg on 2017-12-18.
//  Copyright © 2017 Nicolas Bettenburg. All rights reserved.
//

import Foundation

class KnotHash {
    // The desired length of the knothash data
    private let length: Int
    // The internal knothash data
    private var data: [Int]
    
    // Constructor
    init(length: Int) {
        self.length = length
        self.data = Array(0...length)
    }
    
    // Single round knot
    func knot(input: [Int]) {
        var pos: Int = 0
        var skip: Int = 0
        for i in input {
            // "Pinch"
            rotate(n_elements: i, starting_at: pos)
            // "Twist"
            pos = (pos + i + skip) % length
            skip += 1
        }
    }
    
    // Multi round knot
    func knot(input: [Int], rounds: Int) {
        var multi_input = [Int]()
        for _ in (0..<rounds) {
            multi_input += input
        }
        knot(input: multi_input)
    }
    
    func knot(input: String, rounds: Int = 1) {
        let input_array = str2input(str: input)
        self.knot(input: input_array, rounds: rounds)
    }
    
    // Rotate elements
    func rotate(n_elements: Int, starting_at: Int) {
        // Declare an empty temporary array
        var tmp = [Int]()
        
        // Take n_elements from starting_at and add them to tmp
        // note that taking elements needs by cyclic over data
        let end_idx = starting_at + n_elements
        for idx in (starting_at..<end_idx) {
            let pos = idx % length
            tmp += [data[pos]]
        }
        
        // Reverse tmp
        tmp.reverse()
        
        // And add values back into data
        for idx in (starting_at..<end_idx) {
            let pos = idx % length
            data[pos] = tmp[idx-starting_at]
        }
    }
    
    func dense_hash() -> String {
        var hex = [Int]()
        for i in (0...15) {
            let sub = data[16*i..<16*i+16]
            var d = 0
            for value in sub {
                d = d ^ value
            }
            hex += [d]
        }
        var hash = ""
        for d in hex {
            hash += String.init(format: "%02x", d)
        }
        return hash
    }
    
    // Convert input string to byte array with pad if given
    func str2input(str: String, pad: [Int] = [17, 31, 73, 47, 23]) -> [Int] {
        let bstr = str.utf8.map({ (cp: UInt8) -> Int in
            return Int(cp)
        })
        let bs = bstr + pad
        return bs
    }
    
    // Calculate checksum
    func checksum() -> Int {
        let cs = data[0] * data[1]
        return cs
    }
    
    func debug() -> String {
        return self.data.debugDescription
    }
}
