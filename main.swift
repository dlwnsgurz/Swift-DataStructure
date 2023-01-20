//
//  main.swift
//  SwiftDataStructure
//
//  Created by LEE on 2023/01/20.
//

import Foundation

var stack = Stack<Int>()

for number in 0...100{
    stack.push(number)
    print(stack.top!)
}

for number in 0...101{
    print("pop :  \(stack.top)")
    stack.pop()
}

var stack2: Stack = [1,2,3,4]

stack2.push(2323)

stack2 = [1,2,3,4]

for item in stack2{
    print(item)
}
