//: Playground - noun: a place where people can play
// Closure

/* Closures can capture and store references to any constants and variables from the context in which they are defined. This is known as closing over those constants and variables, hence the name “closures”. Swift handles all of the memory management of capturing for you.
*/

/* functions and closures are reference types
    incrementer() is closure with the references to variables runningTotal and amount
Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a reference to the function or closure. 
if you assign a closure to two different constants or variables, both of those constants or variables will refer to the same closure

*/

/* Closure infers a lot of things from your calling object like numbers array, names array whenever is obvious. So it is kind of magical. Read the bottom Shorthand version and Tailing Closure.
*/

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let myIncrementByFive = makeIncrementer(forIncrement: 5)
myIncrementByFive()
myIncrementByFive()

incrementByTen()

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()

/* Closure Types 
    Global functions are closures that have a name and do not capture any values.
    Nested functions are closures that have a name and can capture values from their enclosing function.
    Closure expressions or unnamed closures written in a lightweight syntax that can capture values from their surrounding context.

Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:

Inferring parameter and return value types from context
Implicit returns from single-expression closures
Shorthand argument names
Trailing closure syntax
*/

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

names.sort({
    s1, s2 in
    return s1 > s2
})

// names.sort(<#T##isOrderedBefore: (String, String) -> Bool##(String, String) -> Bool#>) is the signature
// equivalent to 
// names.sort(_:)

func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversed = names.sort(backwards)


/*
Closure expression syntax has the following general form:
It is also called Inline Closure Expression

{ (parameters) -> return type in
statements
}

or
{ parameters in 
    statements
}

*/

var reversed2 = names.sort( {
    (s1: String, s2: String) -> Bool in
    
    return s1 > s2
})

reversed2

/* Further simplified 
Because the sorting closure is passed as an argument to a method names.sort, Swift can infer the types of its parameters and the type of the value it returns.

This means that the (String, String) and Bool types do not need to be written as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (->) and the parentheses around the names of the parameters can also be omitted:
*/
var reversed3 = names.sort(
    {
        s1, s2 in         // in is a keyword
        return s1 > s2   // statement
    }
)

reversed3

// Shorthand Argument Names 
/*
    If you use these shorthand argument names within your closure expression, 
        you can **omit the closure’s argument list from its definition, 
        and the number and type of the shorthand argument names will be **inferred from the expected function type. 
    ** The in keyword can also be omitted, because the closure expression is made up entirely of its body:
    Here, $0 and $1 refer to the closure’s first and second String arguments.
*/
var reversed4 = names.sort ( {
    $0 > $1
})

/*
Operator Functions

There’s actually an even shorter way to write the closure expression above. Swift’s String type defines its string-specific implementation of the greater-than operator (>) as a function that has two parameters of type String, and returns a value of type Bool. This exactly matches the function type needed by the sort(_:) method. Therefore, you can simply pass in the greater-than operator, and Swift will infer that you want to use its string-specific implementation:

reversed = names.sort(>)
*/

var reversed5 = names.sort(>)

/* Trailing Closure 
func someFunctionThatTakesAClosure(closure: () -> Void) {
// function body goes here
}

// here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure({
// closure's body goes here
})

OR

// here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
// trailing closure's body goes here
}

**Trailing closures are most useful when the closure is sufficiently long that it is not possible to write it inline on a single line. As an example, Swift’s Array type has a map(_:) method which takes a closure expression as its single argument. The closure is called once for each item in the array, and returns an alternative mapped value (possibly of some other type) for that item. The nature of the mapping and the type of the returned value is left up to the closure to specify.

After applying the provided closure to each array element, the map(_:) method returns a new array containing all of the new mapped values, in the same order as their corresponding values in the original array.

Here’s how you can use the map(_:) method with a trailing closure to convert an array of Int values into an array of String values. The array [16, 58, 510] is used to create the new array ["OneSix", "FiveEight", "FiveOneZero"]:
*/
let digitNames = [
0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

/*The code above creates a dictionary of mappings between the integer digits and English-language versions of their names. It also defines an array of integers, ready to be converted into strings.

You can now use the numbers array to create an array of String values, by passing a closure expression to the array’s map(_:) method as a trailing closure:
*/

let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}


/*
// strings is **inferred** to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]

    The map(_:) method calls the closure expression once for each item in the array. 
    
    **You do not need to specify the type of the closure’s input parameter, number, because the type can be **inferred** from the values in the array to be mapped.

In this example, the closure’s number parameter is defined as a variable parameter, as described in Constant and Variable Parameters, so that the parameter’s value can be modified within the closure body, rather than declaring a new local variable and assigning the passed number value to it. The closure expression also specifies a return type of **String**, to indicate the type that will be stored in the mapped output array.

The closure expression builds a string called output each time it is called. It calculates the last digit of number by using the remainder operator (number % 10), and uses this digit to look up an appropriate string in the digitNames dictionary. The closure can be used to create a string representation of any integer number greater than zero.

*/

/* 

*/

