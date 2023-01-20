var q = ImprovedQueue<String>()


q.push_back("Ada")
q.push_back("Steve")
q.push_back("Tim")     // [{Some "Ada"}, {Some "Steve"}, {Some "Tim"}]
print(q.size)             // 3

q.pop_front()       // "Ada"     // [nil, {Some "Steve"}, {Some "Tim"}]
print(q.size)           // 2

q.pop_front()         // "Steve"
           // [nil, nil, {Some "Tim"}]
print(q.size)           // 1

q.push_back("Grace")             // [nil, nil, {Some "Tim"}, {Some "Grace"}]
print(q.size)      // 2
