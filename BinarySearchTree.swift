class BinarySearchTreeByLinkedList<Element: Comparable>{
    
    private(set) var count = 0
    
    var root: Node<Element>?
    
    func insert(_ data: Element){
        guard let root = self.root else {
            self.root = Node(data: data)
            return
        }
        var currentNode = root
        while true{
            if data > currentNode.data{
                guard let right = currentNode.right else {
                    currentNode.right = Node(data: data)
                    count += 1
                    return
                }
                currentNode = right
            }else if data < currentNode.data{
                guard let left = currentNode.left else {
                    currentNode.left = Node(data: data)
                    count += 1
                    return
                }
                currentNode = left
            }
        }
    }
    
    func search(for data: Element) -> Bool{
        guard let root = self.root else {
            return false
        }
        
        var currentNode = root
        while true{
            if data > currentNode.data {
                guard let right = currentNode.right else {
                    return false
                }
                currentNode = right
            }else if data < currentNode.data{
                guard let left = currentNode.left else {
                    return false
                }
                currentNode = left
            }else{
                return true
            }
        }
    }
    
    func remove(data: Element) -> Bool{
        if !search(for: data) { return false }
        guard let root = self.root else { return false }
        
        /// 삭제할 노드의 부모 노드
        var parentNode = root
        
        /// 삭제할 노드를 탐색하기 위한 노드.
        var currentNode : Node? = root
        
        /// 삭제할 노드 탐색
        while let node = currentNode{
            if data > node.data{
                currentNode = node.right
            }else if data < node.data{
                currentNode = node.left
            }else{ break }
            parentNode = node
        }
        
        /// 삭제할 노드의 자식 노드가 없는 경우
        if currentNode?.left == nil && currentNode?.right == nil {
            if data > parentNode.data { parentNode.right = nil }
            else if data < parentNode.data { parentNode.left = nil }
            self.count -= 1
            return true
        }
        
        /// 삭제할 노드의 자식 노드가 1개인 경우
        if currentNode?.left != nil && currentNode?.right == nil{   // 삭제할 노드가 왼쪽 자식 노드만 있는 경우.
            if data > parentNode.data{  // 삭제할 노드가 부모 노드의 오른쪽 자식인 경우.
                parentNode.right = currentNode!.left
            }else if data < parentNode.data{    // 삭제할 노드가 부모 노드의 왼쪽 자식인 경우.
                parentNode.left = currentNode!.left
            }
            self.count -= 1
            return true
        }else if currentNode?.right != nil && currentNode?.left == nil{ // 삭제할 노드가 오른쪽 자식 노드만 있는 경우.
            if data > parentNode.data{  // 삭제할 노드가 부모 노드의 오른쪽 자식인 경우.
                parentNode.right = currentNode!.right
            }else if data < parentNode.data{    // 삭제할 노드가 부모 노드의 왼쪽 자식인 경우.
                parentNode.left = currentNode!.right
            }
            self.count -= 1
            return true
        }
        
        /// 삭제할 노드의 자식 노드가 2개인 경우
        /// 삭제할 노드의 오른쪽 자식 노드들 중, 가장 작은 노드를 삭제할 노드와 교체.
        var leafNode = currentNode!.right
        var leafParentNode = currentNode
        
        while let leaf = leafNode?.left{
            leafParentNode = leafNode
            leafNode = leaf
        }
        
        /// 찾은 가장 작은 노드가 오른쪽 자식 노드가 있다면
        if let right = leafNode?.right{
            leafParentNode?.left = right
        }else{
            leafParentNode?.left = nil
        }
        
        /// 리프 노드가 삭제할 노드를 대체
        leafNode?.left = currentNode?.left
        leafNode?.right = currentNode?.right
        
        if data > parentNode.data{
            parentNode.right = leafNode
        }else if data < parentNode.data{
            parentNode.left = leafNode
        }
        self.count -= 1
        return true
    }

    
}


class Node<Element: Comparable>{
    
    var data: Element
    var left: Node<Element>?
    var right: Node<Element>?
    
    init(data: Element){
        self.data = data
    }
}


extension BinarySearchTreeByLinkedList{
    func drawDiagram() {
        print(diagram(for: self.root))
    }
     
    private func diagram(for node: Node<Element>?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
       guard let node = node else {
            return root + "nil\n"
        }
        if node.left == nil && node.right == nil {
            return root + "\(node.data)\n"
        }
        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.data)\n"
            + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

class BinarySearchTree<Element: Comparable>{
    
    var value: Element
    var parent: BinarySearchTree<Element>?
    var left: BinarySearchTree<Element>?
    var right: BinarySearchTree<Element>?
    
    init(value: Element){
        self.value = value
    }
    
    convenience init(array: [Element]){
        self.init(value: array[0])
        for i in 1..<array.count{
            insert(value: array[i])
        }
    }
    
    var isRoot: Bool{
        return parent == nil
    }
    
    var isLeaf: Bool{
        return left == nil && right == nil
    }
    
    var isLeftChild: Bool{
        return parent?.left === self
    }
    
    var isRightChild: Bool{
        return parent?.right === self
    }
    
    var hasLeftChild: Bool{
        return left != nil
    }
    
    var hasRightChild: Bool{
        return right != nil
    }
    
    var hasAnyChild: Bool{
        return hasLeftChild || hasRightChild
    }
    
    var hasBothChild: Bool{
        return hasLeftChild && hasRightChild
    }
    
    func insert(value: Element){
        if value < self.value{
            if let left = self.left{
                left.insert(value: value)
            }else{
                left = BinarySearchTree(value: value)
                left?.parent = self
            }
        }else{
            if let right = self.right{
                right.insert(value: value)
            }else{
                right = BinarySearchTree(value: value)
                right?.parent = self
            }
        }
    }
    
    func recursiveSearch(value: Element) -> BinarySearchTree?{
        if value < self.value{
            return left?.recursiveSearch(value: value)
        }else if value > self.value{
            return right?.recursiveSearch(value: value)
        }else{
            return self
        }
    }
    
    func loopSearch(value: Element) -> BinarySearchTree?{
        var node: BinarySearchTree? = self
        while let n = node{
            if value > n.value{
                node = n.right
            }else if value < n.value{
                node = n.left
            }else{
                return node
            }
        }
        return nil
    }
    
    func traverseInOrder(process: (Element) -> ()){
        left?.traverseInOrder(process: process)
        process(self.value)
        right?.traverseInOrder(process: process)
    }
    
    func traverseInPreOrder(process: (Element) -> ()){
        process(self.value)
        left?.traverseInOrder(process: process)
        right?.traverseInOrder(process: process)
        
    }
    
    func traverseInPostOrder(process: (Element) -> ()){
        left?.traverseInOrder(process: process)
        right?.traverseInOrder(process: process)
        process(self.value)
    }
    
    func map(formular: (Element) -> Element) -> [Element]{
        var array = [Element]()
        if let left = left { array += left.map(formular: formular)}
        array.append(value)
        if let right = right { array += right.map(formular: formular)}
        return array
    }
    
    func toArray() -> [Element]{
        return map{ $0 }
    }
    
    private func reconnectParentTo(node: BinarySearchTree?){
        if let parent = parent{
            if isLeftChild{
                parent.left = node
            }else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    func minimum() -> BinarySearchTree{
        var node = self
        while let next = node.left{
            node = next
        }
        return node
    }
    
    func maximum() -> BinarySearchTree{
        var node = self
        while let next = node.right{
            node = next
        }
        return node
    }
    
    @discardableResult
    func remove() -> BinarySearchTree?{
        let replacement: BinarySearchTree?
        
        if let right = right{
            replacement = right.minimum()
        }else if let left = left{
            replacement = left.maximum()
        }else{
            replacement = nil
        }
        
        replacement?.remove()
        
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node:replacement)

        // The current node is no longer part of the tree, so clean it up.
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    func height() -> Int{
        if isLeaf {
            return 0
        }else{
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    func depth() -> Int{
        var node = self
        var edge = 0
        while let level = node.parent{
            node = level
            edge += 1
        }
        return edge
    }
}


enum BinarySearchTreeByEnumeration<Element: Comparable>{
    case Empty
    case Leaf(Element)
    indirect case Node(BinarySearchTreeByEnumeration, Element, BinarySearchTreeByEnumeration)
    
    
    var count: Int{
        switch self{
        case .Empty : return 0
        case .Leaf : return 1
        case let .Node(left, _ , right) : return left.count + right.count + 1
        }
    }
    
    var height: Int{
        switch self{
        case .Empty : return -1
        case .Leaf : return 0
        case let .Node(left, _, right): return 1 + max(left.height , right.height)
        }
    }
    
    func insert(newValue: Element) -> BinarySearchTreeByEnumeration{
        switch self{
        case .Empty:
            return .Leaf(newValue)
        case .Leaf(let value) :
            if value < newValue { return .Node(.Empty, value, .Leaf(newValue))}
            else { return .Node(.Leaf(newValue), value, .Empty)}
        case .Node(let left, let value, let right):
            if value < newValue { return .Node(left, value, insert(newValue: newValue))}
            else { return .Node(insert(newValue: newValue), value, right)}
        }
    }
    
    func search(x: Element) -> BinarySearchTreeByEnumeration?{
        switch self{
        case .Empty:
            return nil
        case .Leaf(let y):
            return (x==y) ? self : nil
        case .Node(let left, let y, let right):
            if x > y { return right.search(x: x)}
            else if x < y{ return left.search(x: x)}
            else { return self }
        }
    }
    
}
