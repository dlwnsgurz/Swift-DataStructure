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
