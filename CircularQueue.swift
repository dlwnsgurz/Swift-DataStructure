struct CircularQueue<Element>{
    
    var elements: [Element?]
    var front = 0
    var rear = 0
    var size = 0
    var isEmpty: Bool{
        return size == 0
    }
    
    var peekFront: Element?{
        if isEmpty { return nil }
        return elements[front]
    }
    
    var peekRear: Element?{
        if isEmpty { return nil }
        return elements[(((rear - 1) % elements.count) + elements.count) % elements.count]
    }
    
    init(size: Int){
        let arraySize = max(10, size)
        self.elements = [Element?](repeating: nil, count: arraySize)
    }
    
    mutating func enqueue(_ element: Element){
        
        if size != elements.count{
            elements[rear] = element
            rear = (rear + 1) % elements.count
        }else{
            var emptySpace = [Element?](repeating: nil, count: elements.count * 2)
            for index in 0..<rear{
                emptySpace[index] = elements[index]
            }
            rear += elements.count
            elements.append(contentsOf: emptySpace)
            elements[rear] = element
            rear += 1
        }
        size += 1
        return
    }
    
    @discardableResult
    mutating func dequeue() -> Element?{
        
        if isEmpty { return nil }
        
        let element = elements[front]
        front = (front + 1) % elements.count
        size -= 1
        return element
    }
    
    subscript(index: Int) -> Element?{
        
        if index < 0 || index >= size || isEmpty { return nil }
        return elements[(front + index) % elements.count]
    }
    
}
