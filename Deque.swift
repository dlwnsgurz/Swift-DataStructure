import Foundation

struct Deque<Element>{
    
    var elements: [Element] = []
    
    var size: Int{
        return elements.count
    }
    
    var isEmpty: Bool{
        return elements.isEmpty
    }
    
    var front: Element?{
        return elements.first
    }
    
    var back: Element?{
        return elements.last
    }
    
    mutating func push_front(_ element: Element){
        elements.insert(element, at: 0)
    }
    
    mutating func push_back(_ element: Element){
        elements.append(element)
    }
    
    mutating func pop_front() -> Element?{
        if isEmpty { return nil }
        return elements.removeLast()
    }
    
    mutating func pop_back() -> Element?{
        if isEmpty { return nil }
        return elements.removeFirst()
    }
}


struct ImprovedDeque<Element>{
    
    var elements: [Element?] = []
    var capacity: Int
    let originalCapacity: Int
    var head: Int
    
    init(_ capacity: Int = 10){
        self.capacity = max(1, capacity)
        elements = [Element?](repeating: nil, count: capacity)
        originalCapacity = capacity
        head = capacity
    }
    
    var size: Int{
        return elements.count - head
    }
    
    var isEmpty: Bool{
        return size == 0
    }
    
    var front: Element?{
        if isEmpty { return nil }
        
        return elements[head]
    }
    
    var back: Element?{
        return elements.last!
    }
    
    mutating func push_front(_ element: Element){
        if head == 0{
            capacity *= 2
            let emptySpace = [Element?](repeating: nil, count: capacity)
            elements.insert(contentsOf: emptySpace, at: 0)
            head = capacity
        }
        head -= 1
        elements[head] = element
        
    }
    
    mutating func push_back(_ element: Element){
        elements.append(element)
    }
    
    mutating func pop_back() -> Element?{
        if isEmpty { return nil }
        return elements.removeLast()
    }
    
    mutating func pop_front() -> Element?{
        guard !isEmpty, let element = elements[head] else{
            return nil
        }
        
        elements[head] = nil
        head += 1
        
        if capacity >= originalCapacity && head >= 2*capacity{
            let removeCapacity = capacity + capacity / 2
            head -= removeCapacity
            elements.removeFirst(removeCapacity)
            capacity /= 2
        }
        
        return element
    }
    
}
