class HashTable<Value>{
    
    private(set) var hashTable: [Node<Value>?]
    private(set) var count = 0
    
    func hash(to key: String) -> Int {
        return (abs(key.hashValue)) % 5
    }
    
    init(){
        hashTable = [Node<Value>?](repeating: nil, count: 5)
    }
    
    func updateValue(_ value: Value, forKey key: String){
        let index = hash(to: key)
        guard let node = hashTable[index] else {
            hashTable[index] = Node(key: key, value: value)
            count += 1
            return
        }
        
        let newNode = Node(key: key, value: value)
        newNode.next = hashTable[index]
        hashTable[index] = newNode
        count += 1
        return
    }
    
    @discardableResult
    func remove(forKey key: String) -> Bool{
        let index = hash(to: key)
        if hashTable[index] == nil { return false }
        
        var node = hashTable[index]
        var tracking = node
        while true {
            if key == node?.key {
                tracking?.next = node?.next
                count -= 1
                return true
            }
            if node?.next == nil { return false }
            tracking = node
            node = node?.next
        }
    }
    
    subscript(key: String) -> Value?{
        get{
            let index = hash(to: key)
            if hashTable[index] == nil { return nil }
            
            var node = hashTable[index]
            var tracking = node
            
            while true{
                if key == node?.key{ return node?.value }
                if node?.next == nil { return nil }
                tracking = node
                node = node?.next
            }
        }
        set{
            if let value = newValue{
                self.updateValue(value, forKey: key)
            }else{
                self.remove(forKey: key)
            }
        }
    }
    
    func printHashTable(){
        for (index, node) in hashTable.enumerated(){
            print("HashTable Index : \(index)", terminator: " | ")
            var currentNode = node
            while true{
                print("\(currentNode?.value) -> ",terminator: "")
                guard let next = currentNode?.next else {
                    print("\(currentNode?.next?.value)")
                    break
                }
                currentNode = next
            }
        }
    }
}

class Node<Value>{
    
    var next: Node?
    var key: String
    var value: Value
    
    init(key: String, value: Value){
        self.key = key
        self.value = value
    }
}



