import Foundation

struct Queue<Element>{
    
    private var elements: [Element] = []
    
    public var isEmpty: Bool{
        return elements.isEmpty
    }
    
    /// 큐의 현재 원소 개수를 return.
    public var size: Int{
        return elements.count
    }
    
    /// 큐의 뒤에 원소를 추가.
    public mutating func push_back(_ element: Element){
        elements.append(element)
    }
    
    /// 큐의 앞에 원소를 옵셔널로 return.
    /// 만약, 큐가 비어있다면 nil을 return.
    public var front: Element?{
        return elements.first
    }
    
    /// 큐의 마지막 원소를 옵셔널로 return.
    /// 만약, 큐가 비어있다면 nil을 return
    public var back: Element?{
        return elements.last
    }
    
    /// 큐의 앞에 원소를 삭제 후 옵셔널로 return.
    /// 만약, 큐가 비어있다면 nil을 return.
    public mutating func pop_front() -> Element?{
        if isEmpty { return nil }
        return elements.removeFirst()
    }
    
    /// 큐의 원소를 정수 인덱스로 조회해, 원소를 옵셔널로 return
    /// 조회한 인덱스가 잘못되었다면 nil을 return
    public subscript(index: Int) -> Element?{
        if index < 0 { return nil }
        if index >= size { return nil }
        return elements[index]
    }
    
    
}

struct ImprovedQueue<Element>{
    
    private var elements: [Element?] = []
    
    /// 맨 앞 원소의 인덱스.
    private var head: Int = 0
    
    public var isEmpty: Bool{
        return self.size == 0
    }
    
    /// 큐의 원소의 개수를 return.
    public var size: Int{
        return elements.count - head
    }
    
    /// 큐의 뒤에 원소를 추가.
    public mutating func push_back(_ element: Element){
        elements.append(element)
    }
    
    /// 큐의 앞에 원소를 삭제 후 옵셔널로 return.
    /// 만약, 큐가 비어있다면 nil을 return.
    public mutating func pop_front() -> Element?{
        
        guard !isEmpty, let element = elements[head] else { return nil }
        
        elements[head] = nil
        head += 1
        
        let persentage = Double(head) / Double(elements.count)
        
        if elements.count > 50 && persentage > 0.25{
            elements.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    /// 큐의 맨 앞에 원소를 return.
    /// 큐의 원소가 없다면 nil을 return
    public var front: Element?{
        if isEmpty { return nil }
        return elements[head]
    }
    
}
