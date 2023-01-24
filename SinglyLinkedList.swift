class SinglyLinkedList<Element>{
    
    
    var dummyNode: Node<Element> = Node(nil)
    var tailNode: Node<Element>?
    
    var isEmpty: Bool{
        return dummyNode.next == nil
    }
    var size = 0
    
    init(with data: Element){
        dummyNode.next = Node(data)
        tailNode = dummyNode.next
        size = 1
    }
    
    /// 연결리스트의 맨 뒤에 노드를 추가
    func append(_ data: Element){
        let new = Node(data)
        tailNode!.next = new
        tailNode = new
        size += 1
    }
    
    /// 연결리스트의 맨 앞에 노드를 추가
    func prepend(_ data: Element){
        let new = Node(data)
        new.next = dummyNode.next
        dummyNode.next = new
        size += 1
    }
    
    /// 연결리스트의 맨 앞의 노드를 삭제
    @discardableResult
    func removeFirst() -> Element?{
        guard let removeNode = dummyNode.next, !isEmpty else { return nil }
        dummyNode.next = removeNode.next
        size -= 1
        return removeNode.data
    }
    
    /// 연결리스트의 맨 뒤의 노드를 삭제
    @discardableResult
    func removeLast() -> Element? {
        if isEmpty { return nil }
        var iterator = dummyNode
        while iterator.next?.next != nil{
            iterator = iterator.next!
        }
        let removeNode = tailNode
        tailNode = iterator
        iterator.next = nil
        size -= 1
        return removeNode?.data
    }
    /// 연결리스트의 모든 데이터를 출력
    func printAll(){
        
        if isEmpty { print("Nan-Nodes"); return }

        var iterator = dummyNode
        while iterator.next != nil{
            iterator = iterator.next!
            print(iterator.data!, terminator: " ")
        }
        print(""); print("")
        
    }
    
    /// 연결리스트의 인덱스에 노드 추가.
    /// 노드 추가 성공시 return true
    /// 잘못된 인덱스 입력 시 return false
    @discardableResult
    func insert(_ data: Element, at index: Int) -> Bool{
        
        if index < 0 || index > size { return false }
        
        let newNode = Node(data)
        var iterator = dummyNode
        
        for _ in 0..<index{
            iterator = iterator.next!
        }
        
        newNode.next = iterator.next
        iterator.next = newNode
        
        if index == size { tailNode = newNode }
        if index == 0 { dummyNode.next = newNode }
        
        size += 1
        
        return true
    }
    
    @discardableResult
    func remove(at index: Int) -> Bool{
        
        if index < 0 || index >= size { return false }
        
        var iterator = dummyNode
        for _ in 0..<index{
            iterator = iterator.next!
        }
        
        if tailNode === iterator.next {
            tailNode = iterator
            iterator.next = nil
        }else{
            iterator.next = iterator.next?.next
        }
        
        size -= 1
        
        return true
    }
    
    subscript(index: Int) -> Element?{
        
        if index < 0 || index >= size || isEmpty { return nil }
        
        var iterator = dummyNode.next!
        for _ in 0..<index{
            iterator = iterator.next!
        }
        return iterator.data!
    }
    
}

class Node<Element>{
    
    var data: Element?
    var next: Node?
    
    init(_ data: Element?, _ next: Node? = nil){
        self.data = data
        self.next = next
    }
    
}
