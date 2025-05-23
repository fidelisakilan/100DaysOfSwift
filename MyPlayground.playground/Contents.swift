import Cocoa

let greeting = """
    Hello, \"playground\"
    """
let nameLength = greeting.count
print(nameLength)
print(greeting.uppercased())
print(greeting.hasPrefix("Hellk"))

let score = 10

print(score.isMultiple(of: 5))

let luggageCode = "1" + "2" + "3" + "4" + "5"
let message = "\(greeting) Hi \(score)"

// checkpoint 1
let temp = 59.0
let tempInFarenheit = (temp * 9) / 5 + 32
print(" \(temp)° C \(tempInFarenheit)° F")

var beatles = ["John", "Paul", "George", "Ringo"]

var albums = [String]()
albums.append("Red")
albums.append("Folklore")
albums.append("Fearless")
print(albums.count)
albums.remove(at: 1)
print(albums.sorted())
print(albums.reversed())

let employee = [
    "name": "Taylor Swift",
    "job": "Singer",
    "location": "Nashville",
]
print(employee["name", default: "Unknown"])
print(employee["job", default: "Unknown"])
print(employee["location", default: "Unknown"])

let olympics = [
    2012: "london",
    2013: "Rio de Janiro",
    2021: "Tokyo",
]
print(olympics[2012, default: "Unknown"])
var heights = [String: Int]()
heights["LeBron James"] = 190

var actors = Set<String>()
actors.insert("Keanu Reeves")
actors.insert("Brad Pitt")
actors.insert("Tom Cruise")
actors.insert("Tom Cruise")
print(actors)

enum Weekday {
    case monday, tuesday, wednesday, thursday, friday
}
var day = Weekday.monday
day = .tuesday

let surname: String = "Lasso"
var score1: Double = 0
var albums1: [String] = ["Hybrid theory", "One more light"]
var user1: [String: String] = ["name": "Akilan"]

var teams: [String] = [String]()
var classes: [String] = []
var clubs = [String]()

enum UIStyle {
    case light, dark, system
}
var theme = UIStyle.light
theme = .dark

let username: String
username = "Akilan"
print(username)

// Checkpoint 2
var tracks: [String] = [
    "Imola", "COTA", "Monza", "Nurburgring", "Suzuka", "COTA",
]
print(tracks)
print(tracks.count)
var uniqueTracks: Set<String> = Set(tracks)
print(uniqueTracks)
print(uniqueTracks.count)

if tracks.isEmpty {
    print("Do Something")
}

enum Weather {
    case sun, rain, snow, wind
}

var forecast = Weather.sun

switch forecast {
case .sun:
    print()
case .rain:
    print()
case .snow:
    print()
case .wind:
    print()
}

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're a batman")
    fallthrough
case "Megacity 1":
    print("You're a noob")
    fallthrough
default:
    print("Who are you")
}

let age = 21
let canVote = age >= 18 ? "Yes" : "No"

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]

for p in platforms {
    print("Swift works great in \(p)")
}

for i in 1...12 {
    print(i)
}

for _ in 0..<12 {
    print("Hey mom")
}

var countdown = 10

while countdown > 0 {
    print("counting down to \(countdown)")
    countdown -= 1
}
print("blast off")

let number: Int = Int.random(in: 1...1000)
let decimal: Double = Double.random(in: 0...1)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("Rolled \(roll)")
}
print("Critical hit")

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)
    }
    if multiples.count >= 10 {
        break
    }
}
print(multiples)

// Checkpoint

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("Fizz")
    } else if i.isMultiple(of: 5) {
        print("Buzz")
    } else {
        print(i)
    }
}

func function1() {
    print("Hello there")
}
function1()

func rollDice() -> Int {
    return Int.random(in: 1...6)
}
let result = rollDice()
print(result)

func isAnagram(a: String, b: String) -> Bool {
    return a.sorted() == b.sorted()
}

print(isAnagram(a: "tesla", b: "slate"))

func pythogoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

pythogoras(a: 3, b: 4)

func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Akilan",lastName: "Amithasagaran")
}

let user2 = getUser()
print("\(user2.0) \(user2.1)")

let (firstName, lastName) = getUser()
print("\(firstName) \(lastName)")

func isUpperCase(_ string: String) -> Bool {
    string == string.uppercased()
}
print(isUpperCase("AKILAN"))

func printTimeTables(for number: Int, end: Int = 20) {
    for i in 1...end {
        print("\(i) x \(number) is \(i*number)")
    }
}

printTimeTables(for: 6)
printTimeTables(for: 6, end: 10)

// Errors in functions
enum PasswordError: Error {
    case obvious, short
}
func checkPassword(_ string: String) throws -> String {
    if string.count < 8 { throw PasswordError.short}
    if string == "12345" { throw PasswordError.obvious}
    return "OK"
}
let string = "12345"
do {
    let result = try checkPassword(string)
    print(result)
} catch PasswordError.obvious{
    print("Too Obvious")
} catch PasswordError.short{
    print("Too Short")
}
catch {
    print("Error occurred \(error.localizedDescription)")
}


// Checkpoint 4

enum SqrtError : Error {
    case outOfBounds, noRoot
}

func findSqrt(number: Int) throws -> Int {
    if number < 1 || number > 100_000 { throw SqrtError.outOfBounds }
    for i in 1...100 {
        if (i * i) == number {
            return i
        }
    }
    throw SqrtError.noRoot
}

do {
    let result = try findSqrt(number: 0)
    print(result)
}
catch SqrtError.noRoot{
    print("NoROOT")
} catch SqrtError.outOfBounds{
    print("OutofBOUNDS")
}catch {
    print("\(error.localizedDescription)")
}


func greetUser() {
    print("Hi, there")
}

let greetCopy: () -> Void = greetUser

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "A"
    }
    return "B"
}

let userCopy: (Int) -> String = getUserData
print(userCopy(1989))

let team = ["Gloria", "Piper", "Susan", "Andrew", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1:String, name2: String) -> Bool {
    if name1 == "Piper" {
        return true
    }else if name2 == "Piper" {
        return false
    }else {
        return name1 < name2
    }
}

//let captainFirstTeam = team.sorted(by: captainFirstSorted)
//print(captainFirstTeam)

let captainFirstTeam = team.sorted{
    //    (name1: String, name2: String) -> Bool in
    //    name1, name2 in
    if $0 == "Piper" {
        return true
    }else if $1 == "Piper" {
        return false
    }else {
        return $0 < $1
    }
}
print(captainFirstTeam)

let reverseTeam = team.sorted{ $0 > $1 }
let tOnlyNames = team.filter{ $0.hasPrefix("T") }
print(tOnlyNames)

let uppercaseTeam = team.map{ $0.uppercased() }
print(uppercaseTeam)

func doImportantTask(first: () -> Void,second: () -> Void, third:() -> Void) {
    print("calling first")
    first()
    print("calling second")
    second()
    print("calling third")
    third()
}

doImportantTask{
    print("Hi 1")
}second: {
    print("Hi 2")
}third: {
    print("Hi 3")
}


// Checkpoint 5
let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]
//
//func doImportantThrice(number: [Int], filter: ([Int]) -> [Int], sort: ([Int]) -> [Int], map: ([Int]) -> [String]) -> [String] {
//    map(sort(filter(number)))
//}
//
//let result1 = doImportantThrice(number: luckyNumbers){ list in
//    list.filter{ !$0.isMultiple(of: 2) }
//}sort: { list in
//    list.sorted()
//}map: { list in
//    list.map{ "\($0) is a lucky number" }
//}
//print(result1)

let result1 = luckyNumbers.filter{ !$0.isMultiple(of: 2)}.sorted().map{
    "\($0) is a lucky number"
}
print(result1)

struct Employee {
    let name: String
    var vacationAllocated = 20
    var vacationTaken = 0
    var vatationRemaining : Int {
        get {
            return vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
    
    mutating func takeVacation(days: Int) {
        if vacationAllocated > days {
            vacationAllocated -= days
            print("Taking vacation")
        } else {
            print("Error not enough days left")
        }
    }
}
var red = Employee(name: "Kayne", vacationAllocated: 14)
red.takeVacation(days: 4)

struct Game {
    var score = 0 {
        didSet {
            print("The score now is \(score)")
        }
    }
}

struct App {
    var contacts = [String]() {
        willSet {
            print("current \(contacts), future \(newValue)")
        }
        didSet {
            print("new \(contacts), old \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian")
app.contacts.append("Toto")
app.contacts.append("Allen")


struct Player {
    let name: String
    let number: Int
    private(set) var funds: Double
    
    init(name: String) {
        self.name = name
        self.number = Int.random(in: 1...99)
        self.funds = 0
    }
}

var megan = Player(name: "Megan")
print(megan.number)

struct AppData {
    static let verstion = "1.3 beta 2"
    static let baseUrl = "https://"
}


// Checkpoint 6
//struct Car {
//    let model: String
//    let seats: Int
//    private(set) var currentGear: Int = 1
//
//    mutating func gearUp() {
//        if currentGear < 10 { currentGear += 1 }
//    }
//    mutating func gearDown() {
//        if currentGear > 1 { currentGear -= 1 }
//    }
//}

class EmployeeClass {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("GG from Employee")
    }
}

class Developer: EmployeeClass {
    func work() {
        print("I'm writing code for \(hours).")
    }
    
    override func printSummary() {
        print("GG")
    }
}


class Vehicle {
    let isElectric: Bool
    
    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible = false
}

let teslaX = Car(isElectric: true)


class User2 {
    var userName = "Anonymous"
    func copy() -> User2 {
        var user = User2()
        user.userName = userName
        return user
    }
}

var user3 = User2()
var user4 = user3.copy()
user3.userName = "Akilan"
print(user4.userName)
print(user3.userName)

class User3 {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }
    
    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...5 {
    let user = User3(id: i)
    print("User \(user.id): I'm in control")
}

// Checkpoint

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog : Animal {
    func speak() {
        print("BARK BARK")
    }
}

class Corgi : Dog {
    override func speak() {
        print("CORIG BARK")
    }
}

class Poodle : Dog {
    override func speak() {
        print("Poodle BARK")
    }
}

class Cat : Animal {
    let isTame: Bool
    
    init(legs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    func speak() {
        print("Meow")
    }
}

class Persion : Cat {
    
}

class Lion : Cat {
    
}

protocol Vehicle1 {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

extension String {
    mutating func trim() {
        self = self.trimmed()
    }
    
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var lines : [String]{
        self.components(separatedBy: .newlines)
    }
}

var quote = "        The Truth is rarely pure and never simple     "
let trimmed = quote.trimmed()
print(trimmed)


struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

protocol Person {
    var name: String {get}
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee1 : Person {
    let name: String
}

extension Numeric {
    func squared() -> Self {
        self * self
    }
}

struct User5: Equatable, Comparable {
    let name: String
    static func <(lhs: User5, rhs: User5) -> Bool {
        lhs.name < rhs.name
    }
}


let user5 = User5(name: "Link")
let user6 = User5(name: "Zelda")
print(user5 == user6)
print(user5 != user6)
print(user5 < user6)


protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var realEstateAgent: String { get }
}

extension Building {
    func salesSummary() {
        print("HI")
    }
}

struct House : Building {
    let rooms: Int = 4
    let cost: Int = 100
    let realEstateAgent: String = "Andrew"
}

struct Office : Building {
    let rooms: Int = 10
    let cost: Int = 1000
    let realEstateAgent: String = "Mark"
}

var userName: String? = nil

if let userName = userName {
    print("HI this is not nil \(userName)")
} else {
    print("This is null")
}

func printSquare(number: Int?) {
    guard let number = number else {
        print("Missing Input")
        return
    }
    print("\(number) times \(number) is \(number * number)")
}

let captains = [
    "Enterprise": "Mark",
    "Voyage": "Peter",
]

let new = captains["Office"] ?? "N/A"

enum UserError : Error {
    case badId, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.badId
}

if let user = try? getUser(id: 0) {
    print("user is \(user)")
}

let user = (try? getUser(id: 0)) ?? "N/A"

func getRandomFromList(list: [Int]?) -> Int {
    list?.randomElement() ?? Int.random(in: 1...100)
}


