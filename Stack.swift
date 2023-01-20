import Foundation

struct Stack<Element>{
        

    private var elements: [Element] = []
    
    /// 스택의 현재 원소 개수를 return.
    public var size: Int{
        return elements.count
    }
    
    public var isEmpty: Bool{
        return elements.isEmpty
    }
    
    /// 스택의 가장 마지막 원소를 옵셔널 타입으로 return.
    /// 만약, 원소가 없다면 nil을 return.
    public var top: Element?{
        return self.elements.last
    }
    
    /// 스택의 top에 마지막 원소를 추가
    public mutating func push(_ element: Element){
        elements.append(element)
    }
    
    /// 스택의 가장 마지막 원소를 옵셔널 타입으로 return하고, 삭제합니다.
    /// 만약, 원소가 없다면 nil을 return.
    @discardableResult
    public mutating func pop() -> Element?{
        return elements.popLast()
    }
    
    /// 스택의 원소를 정수 인덱스로 조회해, 원소를 옵셔널로 return
    /// 조회한 인덱스가 잘못되었다면 nil을 return
    public subscript(index: Int) -> Element?{
        if index < 0 { return nil }
        if index >= size { return nil }
        return elements[index]
    }
    
}


extension Stack: ExpressibleByArrayLiteral{

    public init(arrayLiteral elements: Element...){
        for item in elements{
            self.push(item)
        }
    }
}

struct ArrayIterator<Element>: IteratorProtocol{
    
    var elements: [Element] = []
    
    init(elements: [Element]){
        self.elements = elements
    }
    
    mutating func next() -> Element? {
        
        if self.elements.isEmpty{ return nil }
        return elements.removeFirst()
        
    }
    
}

extension Stack: Sequence {

  public func makeIterator() -> ArrayIterator<Element> {
    return ArrayIterator<Element>(elements: self.elements)
  }
}

