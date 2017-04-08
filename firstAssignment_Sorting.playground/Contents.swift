/*
1st assignment for the iOSbootCamp
Sorrting arrays of Int and Strings, here is the linkedlist method
a doubly linked list with a pointer that holds the middle elemnt can cut the
search path in half in each new addition
 to be added: a pointer to the middle element to ease adding.
 */

let greetings = "Hello world!";

class Node<T>
{
    var value:T;
    var next:Node?
    weak var previous:Node?
    
    init(V:T)
    {
        self.value = V;
    }
}

class LinkedList<T:Comparable>
{
     var head:Node<T>?  // to hold the head of the linked list
     var tail:Node<T>?  // to hold the tail
     var temp:Node<T>?  // to hold the temp value and iterate through the loop
    
    public var count = 0;
   
    
    init() // sentinals !!
    {
        
    }
    
    
    init(array:[T]) // sentinals !!
    {
        if (T.self is String.Type)
        {
            for eachItem in array
            {
                self.addStrings(Value1: eachItem );
            }
        }
        else
        {
            for eachItem in array
            {
                self.Add(Value1: eachItem);
            }
        }
    }
    
    private func removeSpecialCharsFromString(_ text: String) -> String
    {
        let okayChars : Set<Character> =
            Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters);
        return String(text.characters.filter {okayChars.contains($0) });
    }
    
    private func compareStringsGreaterThan(_ string1:String,_ string2:String) -> Bool
    {
        // notice here parameters are passed as constants unless you specify a var as i just did
        var result:Bool;
        
        var str1 = removeSpecialCharsFromString(string1);
        var str2 = removeSpecialCharsFromString(string2);
        str1 = str1.uppercased();
        str2 = str2.uppercased();
        
        if(str1>str2)
        {result = true;}
        else
        {result = false;}
        
        
        return result;
    }
    
    
    
    public func Add(Value1:T)
    {
        let newNode = Node(V: Value1)          // here we create the node
        
        if(count == 0)                 // adding the first time
        {
            head = newNode;
            tail = newNode;
            count += 1 ;
            
            
        }
        else if(newNode.value < head!.value) // add before the head
        {
            newNode.next = head;
            head!.previous = newNode;       // force unwrapping bcs i am sure that head holds something
            head = newNode;
            
            count += 1 ;
            
        }
        else if(newNode.value > tail!.value) // adding after the last
        {
            newNode.previous = tail;
            tail!.next = newNode;
            tail = newNode;
            
            count += 1 ;
            
        }
        else  //equal values will be appended in order of addition
        {
            temp = head;
            while(temp!.next!.value < newNode.value) // i cant hit last bcs i already checked that
            {
                temp = temp!.next;
            }
            // check that logic
            newNode.next = temp!.next;
            temp!.next = newNode;
            newNode.next!.previous = newNode;
            newNode.previous = temp;
            
            count += 1 ;
            
        }
        
    }
    //Special add for strings
    
    private func addStrings(Value1:T)
    {
        let newNode = Node(V: Value1)          // here we create the node
        
        if(count == 0)                 // adding the first time
        {
            head = newNode;
            tail = newNode;
            count += 1 ;
        }
        else if(compareStringsGreaterThan(head!.value as! String, newNode.value as! String)) // add before the head
        {
            newNode.next = head;
            head!.previous = newNode;       // force unwrapping bcs i am sure that head holds something
            head = newNode;
            
            count += 1 ;
            
        }
        else if(compareStringsGreaterThan(newNode.value as! String, tail!.value as! String)) // adding after the last
        {
            newNode.previous = tail;
            tail!.next = newNode;
            tail = newNode;
            
            count += 1 ;
            
        }
        else  //equal values will be appended in order of addition
        {
            temp = head;
            while(compareStringsGreaterThan(newNode.value as! String, temp!.next!.value as! String))            {
                temp = temp!.next;
            }
            // check that logic
            newNode.next = temp!.next;
            temp!.next = newNode;
            newNode.next!.previous = newNode;
            newNode.previous = temp;
            count += 1 ;
        }
        
    }
    // Export linkedlist to an array
    func exportLinkedList()-> [T]
    {
        var array:[T] = [] // must be initialized to be an empty array before calling the append function
        temp = head;
        while(temp != nil)
        {
            array.append(temp!.value);
            temp = temp!.next;
        }
        return array;
    }
    
    // print function
    
    public func printLinkedList()->String
    {
        var txt = "[ "
        
        temp = head;
        while(temp != nil)
        {
            txt += String(describing: temp!.value );
            txt += ", ";
            temp = temp!.next;
        }
        txt += " ];End that was \(count) Elements";
        
        return txt;
    }
}


func sortMyArray<T:Comparable>(_ toBeSortedArray:[T])-> [T]
{
    var result:[T];
    let linkedlist = LinkedList(array: toBeSortedArray);
    result = linkedlist.exportLinkedList();
    return result;
    
}



