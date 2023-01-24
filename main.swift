var link = DoublyLinkedList(with: 2)
link.append(4)
link.append(6)
link.append(8)
link.append(10)
link.append(12)

print("size : \(link.size)")
link.printAll()

link.insert(5, at: 0)
link.insert(5, at: 7)
link.append(8)
print("size : \(link.size)")
link.printAll()

link.remove(at:5)
link.remove(at:2)
print("size : \(link.size)")
link.printAll()

link.prepend(4)
link.prepend(1)
print("size : \(link.size)")
link.printAll()

link.remove(at:0)
link.remove(at:8)

print("size : \(link.size)")
link.printAll()


link.remove(at:7)
link.insert(4, at: 2)

print("size : \(link.size)")
link.printAll()


for index in 0..<link.size{
    print("[\(index)] : \(link[index])")
}

print("size : \(link.size)")
link.printAll()
print("first node data : \(link.dummyNode.next!.data!)")
print("last node data : \(link.tailNode!.data!)")

link.removeFirst()
print("size : \(link.size)")
link.printAll()
link.removeLast()
print("size : \(link.size)")
link.printAll()
link.removeFirst()
print("size : \(link.size)")
link.printAll()
link.removeLast()
print("size : \(link.size)")
link.printAll()
link.removeFirst()
print("size : \(link.size)")
link.printAll()
link.removeLast()
print("size : \(link.size)")
link.printAll()
link.removeFirst()
print("size : \(link.size)")
link.printAll()

link.removeLast()
print("size : \(link.size)")
link.printAll()
