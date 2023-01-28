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



struct HashTableByArray<Key: Hashable, Value>{
    
    typealias Element = (key: Key, value: Value)
    typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) var count = 0
    
    var isEmpty: Bool { return count == 0 }
    
    init(capacity: Int){
        buckets = [Bucket](repeating: [], count: max(capacity, 5))
    }
    
    /// 해쉬 값을 리턴
    func index(forKey key: Key) -> Int{
        return abs(key.hashValue) % buckets.count
    }
    
    func value(forKey key: Key) -> Value?{
        let index = index(forKey: key)
        for element in buckets[index]{
            if element.key == key{
                return element.value
            }
        }
        return nil
    }
    
    subscript(key: Key) -> Value?{
        get{
            return value(forKey: key)
        }
        set{
            if let value = newValue{
                updateValue(value, forKey: key)
            }else{
                removeValue(forKey: key)
            }
        }
    }
    
    /// 해시 테이블내에 value를 업데이트 합니다.
    /// 이미 존재하던 key, value를 업데이트한 경우, 업데이트가 되기전 value를 옵셔널로 return합니다.
    /// 이미 존재하던 key, value가 새로 추가된 경우, nil을 return합니다.
    @discardableResult
    mutating func updateValue(_ value: Value, forKey key: Key) -> Value?{
        let index = index(forKey: key)
        
        for (i, element) in buckets[index].enumerated(){
            if element.key == key{
                let oldValue = element.value
                buckets[index][i].value = value
                return oldValue
            }
        }
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
    }
    
    /// 해시 테이블내에 value를 삭제하고, 옵셔널로 리턴합니다.
    /// 삭제할 원소가 없으면 nil을 리턴합니다.
    @discardableResult
    mutating func removeValue(forKey key: Key) -> Value?{
        let index = index(forKey: key)
        
        for (i, element) in buckets[index].enumerated(){
            if element.key == key{
                let removeValue = buckets[index][i].value
                buckets[index].remove(at: i)
                count -= 1
                return removeValue
            }
        }
        
        return nil
    }
    
}
