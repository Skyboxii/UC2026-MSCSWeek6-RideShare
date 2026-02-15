"===============================================
 RIDE SHARING SYSTEM - SMALLTALK IMPLEMENTATION
 Demonstrating OOP Principles: Encapsulation, Inheritance, and Polymorphism
==============================================="

"========== BASE RIDE CLASS - Demonstrates Encapsulation and Polymorphism =========="

Object subclass: #Ride
    instanceVariableNames: 'rideID pickupLocation dropoffLocation distance baseFarePerMile'
    classVariableNames: ''
    package: 'RideSharingSystem'.

"Constructor method"
Ride class >> newWithID: id pickup: pickup dropoff: dropoff distance: dist [
    | instance |
    instance := self new.
    instance initializeWithID: id pickup: pickup dropoff: dropoff distance: dist.
    ^ instance
]

Ride >> initializeWithID: id pickup: pickup dropoff: dropoff distance: dist [
    "Encapsulation: Initialize private instance variables"
    rideID := id.
    pickupLocation := pickup.
    dropoffLocation := dropoff.
    distance := dist.
    baseFarePerMile := 2.00.
]

"Accessor methods - Encapsulation: Controlled access to private data"
Ride >> rideID [
    ^ rideID
]

Ride >> pickupLocation [
    ^ pickupLocation
]

Ride >> dropoffLocation [
    ^ dropoffLocation
]

Ride >> distance [
    ^ distance
]

"Polymorphic methods - will be overridden in subclasses"
Ride >> fare [
    "Calculate base fare"
    ^ distance * baseFarePerMile
]

Ride >> rideDetails [
    "Display ride information"
    Transcript show: '┌─────────────────────────────────────────┐'; cr.
    Transcript show: '│ Ride ID: ', rideID printString; cr.
    Transcript show: '│ Type: ', self rideType; cr.
    Transcript show: '│ Pickup: ', pickupLocation; cr.
    Transcript show: '│ Dropoff: ', dropoffLocation; cr.
    Transcript show: '│ Distance: ', distance printString, ' miles'; cr.
    Transcript show: '│ Fare: $', self fare printString; cr.
    Transcript show: '└─────────────────────────────────────────┘'; cr.
]

Ride >> rideType [
    ^ 'Base Ride'
]

"========== STANDARD RIDE CLASS - Demonstrates Inheritance =========="

Ride subclass: #StandardRide
    instanceVariableNames: ''
    classVariableNames: 'StandardRate'
    package: 'RideSharingSystem'.

StandardRide class >> initialize [
    "Initialize class variable"
    StandardRate := 2.50.
]

StandardRide >> initializeWithID: id pickup: pickup dropoff: dropoff distance: dist [
    "Call superclass initialization"
    super initializeWithID: id pickup: pickup dropoff: dropoff distance: dist.
    baseFarePerMile := StandardRate.
]

"Override fare calculation - Polymorphism"
StandardRide >> fare [
    ^ distance * StandardRate
]

"Override rideDetails - Polymorphism"
StandardRide >> rideDetails [
    Transcript show: '┌─────────────────────────────────────────┐'; cr.
    Transcript show: '│ STANDARD RIDE                           │'; cr.
    Transcript show: '├─────────────────────────────────────────┤'; cr.
    Transcript show: '│ Ride ID: ', rideID printString; cr.
    Transcript show: '│ Pickup: ', pickupLocation; cr.
    Transcript show: '│ Dropoff: ', dropoffLocation; cr.
    Transcript show: '│ Distance: ', distance printString, ' miles'; cr.
    Transcript show: '│ Rate: $', StandardRate printString, '/mile'; cr.
    Transcript show: '│ Fare: $', self fare printString; cr.
    Transcript show: '└─────────────────────────────────────────┘'; cr.
]

StandardRide >> rideType [
    ^ 'Standard'
]

"========== PREMIUM RIDE CLASS - Demonstrates Inheritance =========="

Ride subclass: #PremiumRide
    instanceVariableNames: 'luxuryFee'
    classVariableNames: 'PremiumRate'
    package: 'RideSharingSystem'.

PremiumRide class >> initialize [
    "Initialize class variable"
    PremiumRate := 4.00.
]

PremiumRide class >> newWithID: id pickup: pickup dropoff: dropoff distance: dist fee: fee [
    | instance |
    instance := self new.
    instance initializeWithID: id pickup: pickup dropoff: dropoff distance: dist fee: fee.
    ^ instance
]

PremiumRide >> initializeWithID: id pickup: pickup dropoff: dropoff distance: dist fee: fee [
    "Call superclass initialization"
    super initializeWithID: id pickup: pickup dropoff: dropoff distance: dist.
    baseFarePerMile := PremiumRate.
    luxuryFee := fee.
]

"Override fare calculation - Polymorphism"
PremiumRide >> fare [
    ^ (distance * PremiumRate) + luxuryFee
]

"Override rideDetails - Polymorphism"
PremiumRide >> rideDetails [
    Transcript show: '┌─────────────────────────────────────────┐'; cr.
    Transcript show: '│ ★ PREMIUM RIDE ★                        │'; cr.
    Transcript show: '├─────────────────────────────────────────┤'; cr.
    Transcript show: '│ Ride ID: ', rideID printString; cr.
    Transcript show: '│ Pickup: ', pickupLocation; cr.
    Transcript show: '│ Dropoff: ', dropoffLocation; cr.
    Transcript show: '│ Distance: ', distance printString, ' miles'; cr.
    Transcript show: '│ Premium Rate: $', PremiumRate printString, '/mile'; cr.
    Transcript show: '│ Luxury Fee: $', luxuryFee printString; cr.
    Transcript show: '│ Total Fare: $', self fare printString; cr.
    Transcript show: '└─────────────────────────────────────────┘'; cr.
]

PremiumRide >> rideType [
    ^ 'Premium'
]

"========== ECONOMY RIDE CLASS - Additional Ride Type =========="

Ride subclass: #EconomyRide
    instanceVariableNames: 'discount'
    classVariableNames: 'EconomyRate'
    package: 'RideSharingSystem'.

EconomyRide class >> initialize [
    "Initialize class variable"
    EconomyRate := 1.75.
]

EconomyRide class >> newWithID: id pickup: pickup dropoff: dropoff distance: dist discount: disc [
    | instance |
    instance := self new.
    instance initializeWithID: id pickup: pickup dropoff: dropoff distance: dist discount: disc.
    ^ instance
]

EconomyRide >> initializeWithID: id pickup: pickup dropoff: dropoff distance: dist discount: disc [
    "Call superclass initialization"
    super initializeWithID: id pickup: pickup dropoff: dropoff distance: dist.
    baseFarePerMile := EconomyRate.
    discount := disc.
]

"Override fare calculation - Polymorphism"
EconomyRide >> fare [
    | baseFare |
    baseFare := distance * EconomyRate.
    ^ baseFare * (1.0 - discount)
]

"Override rideDetails - Polymorphism"
EconomyRide >> rideDetails [
    Transcript show: '┌─────────────────────────────────────────┐'; cr.
    Transcript show: '│ 💰 ECONOMY RIDE 💰                      │'; cr.
    Transcript show: '├─────────────────────────────────────────┤'; cr.
    Transcript show: '│ Ride ID: ', rideID printString; cr.
    Transcript show: '│ Pickup: ', pickupLocation; cr.
    Transcript show: '│ Dropoff: ', dropoffLocation; cr.
    Transcript show: '│ Distance: ', distance printString, ' miles'; cr.
    Transcript show: '│ Economy Rate: $', EconomyRate printString, '/mile'; cr.
    Transcript show: '│ Discount: ', (discount * 100) printString, '%'; cr.
    Transcript show: '│ Final Fare: $', self fare printString; cr.
    Transcript show: '└─────────────────────────────────────────┘'; cr.
]

EconomyRide >> rideType [
    ^ 'Economy'
]

"========== DRIVER CLASS - Demonstrates Encapsulation =========="

Object subclass: #Driver
    instanceVariableNames: 'driverID name rating assignedRides'
    classVariableNames: ''
    package: 'RideSharingSystem'.

Driver class >> newWithID: id name: driverName rating: initialRating [
    | instance |
    instance := self new.
    instance initializeWithID: id name: driverName rating: initialRating.
    ^ instance
]

Driver >> initializeWithID: id name: driverName rating: initialRating [
    "Encapsulation: Initialize private instance variables"
    driverID := id.
    name := driverName.
    rating := initialRating.
    assignedRides := OrderedCollection new.  "Private collection"
]

"Accessor methods - Encapsulation"
Driver >> driverID [
    ^ driverID
]

Driver >> name [
    ^ name
]

Driver >> rating [
    ^ rating
]

"Public methods to manipulate private data - Encapsulation"
Driver >> addRide: ride [
    "Add a ride to the private assignedRides collection"
    assignedRides add: ride.
    Transcript show: '✓ Ride #', ride rideID printString, ' assigned to driver ', name; cr.
]

Driver >> getTotalEarnings [
    "Calculate total earnings from all rides"
    | total |
    total := 0.
    assignedRides do: [ :ride | total := total + ride fare ].
    ^ total
]

Driver >> getTotalRides [
    ^ assignedRides size
]

Driver >> getDriverInfo [
    "Display driver information"
    Transcript cr.
    Transcript show: '╔═════════════════════════════════════════╗'; cr.
    Transcript show: '║          DRIVER INFORMATION             ║'; cr.
    Transcript show: '╠═════════════════════════════════════════╣'; cr.
    Transcript show: '║ Driver ID: ', driverID printString; cr.
    Transcript show: '║ Name: ', name; cr.
    Transcript show: '║ Rating: ', rating printString, ' / 5.0'; cr.
    Transcript show: '║ Total Rides: ', self getTotalRides printString; cr.
    Transcript show: '║ Total Earnings: $', self getTotalEarnings printString; cr.
    Transcript show: '╚═════════════════════════════════════════╝'; cr.
    
    assignedRides isEmpty ifFalse: [
        Transcript cr; show: 'Completed Rides:'; cr.
        assignedRides doWithIndex: [ :ride :index |
            Transcript cr; show: '--- Ride ', index printString, ' ---'; cr.
            ride rideDetails.
        ].
    ].
]

"========== RIDER CLASS - Demonstrates Encapsulation =========="

Object subclass: #Rider
    instanceVariableNames: 'riderID name requestedRides'
    classVariableNames: ''
    package: 'RideSharingSystem'.

Rider class >> newWithID: id name: riderName [
    | instance |
    instance := self new.
    instance initializeWithID: id name: riderName.
    ^ instance
]

Rider >> initializeWithID: id name: riderName [
    "Encapsulation: Initialize private instance variables"
    riderID := id.
    name := riderName.
    requestedRides := OrderedCollection new.  "Private collection"
]

"Accessor methods - Encapsulation"
Rider >> riderID [
    ^ riderID
]

Rider >> name [
    ^ name
]

"Public methods to manipulate private data - Encapsulation"
Rider >> requestRide: ride [
    "Add a ride to the private requestedRides collection"
    requestedRides add: ride.
    Transcript show: '✓ Ride #', ride rideID printString, ' requested by ', name; cr.
]

Rider >> getTotalSpent [
    "Calculate total amount spent on all rides"
    | total |
    total := 0.
    requestedRides do: [ :ride | total := total + ride fare ].
    ^ total
]

Rider >> getTotalRides [
    ^ requestedRides size
]

Rider >> viewRides [
    "Display rider information and ride history"
    Transcript cr.
    Transcript show: '╔═════════════════════════════════════════╗'; cr.
    Transcript show: '║          RIDER INFORMATION              ║'; cr.
    Transcript show: '╠═════════════════════════════════════════╣'; cr.
    Transcript show: '║ Rider ID: ', riderID printString; cr.
    Transcript show: '║ Name: ', name; cr.
    Transcript show: '║ Total Rides: ', self getTotalRides printString; cr.
    Transcript show: '║ Total Spent: $', self getTotalSpent printString; cr.
    Transcript show: '╚═════════════════════════════════════════╝'; cr.
    
    requestedRides isEmpty ifFalse: [
        Transcript cr; show: 'Ride History:'; cr.
        requestedRides doWithIndex: [ :ride :index |
            Transcript cr; show: '--- Ride ', index printString, ' ---'; cr.
            ride rideDetails.
        ].
    ].
]

"========== MAIN DEMONSTRATION SCRIPT =========="

"This script demonstrates all OOP principles"

| ride1 ride2 ride3 ride4 ride5 driver1 driver2 rider1 rider2 allRides totalFares |

Transcript clear.
Transcript cr.
Transcript show: '╔═══════════════════════════════════════════════════╗'; cr.
Transcript show: '║                                                   ║'; cr.
Transcript show: '║        RIDE SHARING SYSTEM - SMALLTALK            ║'; cr.
Transcript show: '║   Demonstrating OOP Principles                    ║'; cr.
Transcript show: '║                                                   ║'; cr.
Transcript show: '╚═══════════════════════════════════════════════════╝'; cr.

"========== Initialize Class Variables =========="
StandardRide initialize.
PremiumRide initialize.
EconomyRide initialize.

"========== DEMONSTRATION 1: Creating Rides (Inheritance) =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  CREATING DIFFERENT RIDE TYPES'; cr.
Transcript show: '=================================================='; cr.
Transcript show: 'Demonstrating Inheritance: StandardRide, PremiumRide, and EconomyRide'; cr; cr.

ride1 := StandardRide newWithID: 101 pickup: 'Downtown' dropoff: 'Airport' distance: 15.5.
ride2 := PremiumRide newWithID: 102 pickup: 'Hotel Plaza' dropoff: 'Convention Center' distance: 8.2 fee: 10.0.
ride3 := EconomyRide newWithID: 103 pickup: 'Main St' dropoff: 'Oak Ave' distance: 5.0 discount: 0.20.
ride4 := StandardRide newWithID: 104 pickup: 'University' dropoff: 'Shopping Mall' distance: 12.3.
ride5 := PremiumRide newWithID: 105 pickup: 'Luxury Resort' dropoff: 'Restaurant District' distance: 18.7 fee: 15.0.

Transcript show: '✓ Created 5 rides of different types'; cr.

"========== DEMONSTRATION 2: Encapsulation with Driver =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  ENCAPSULATION - DRIVER CLASS'; cr.
Transcript show: '=================================================='; cr.
Transcript show: 'Demonstrating Encapsulation: Private attributes accessed through public methods'; cr; cr.

driver1 := Driver newWithID: 501 name: 'John Smith' rating: 4.8.
driver2 := Driver newWithID: 502 name: 'Sarah Johnson' rating: 4.9.

Transcript cr; show: 'Adding rides to Driver: ', driver1 name; cr.
driver1 addRide: ride1.
driver1 addRide: ride2.
driver1 addRide: ride3.

Transcript cr; show: 'Adding rides to Driver: ', driver2 name; cr.
driver2 addRide: ride4.
driver2 addRide: ride5.

"========== DEMONSTRATION 3: Encapsulation with Rider =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  ENCAPSULATION - RIDER CLASS'; cr.
Transcript show: '=================================================='; cr.
Transcript show: 'Demonstrating Encapsulation: Private ride history accessed through public methods'; cr; cr.

rider1 := Rider newWithID: 701 name: 'Alice Brown'.
rider2 := Rider newWithID: 702 name: 'Bob Wilson'.

Transcript cr; show: rider1 name, ' requesting rides:'; cr.
rider1 requestRide: ride1.
rider1 requestRide: ride3.

Transcript cr; show: rider2 name, ' requesting rides:'; cr.
rider2 requestRide: ride2.
rider2 requestRide: ride4.
rider2 requestRide: ride5.

"========== DEMONSTRATION 4: Polymorphism =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  POLYMORPHISM DEMONSTRATION'; cr.
Transcript show: '=================================================='; cr.
Transcript show: 'Calling fare() and rideDetails() polymorphically on different ride types:'; cr; cr.

"Store different ride types in a single collection - Polymorphism"
allRides := OrderedCollection new.
allRides add: ride1; add: ride2; add: ride3; add: ride4; add: ride5.

totalFares := 0.
allRides doWithIndex: [ :ride :index |
    Transcript show: 'Ride ', index printString, ':'; cr.
    ride rideDetails.  "Polymorphic call"
    totalFares := totalFares + ride fare.  "Polymorphic call"
    Transcript cr.
].

Transcript show: '╔═════════════════════════════════════════╗'; cr.
Transcript show: '║ Total Fares from All Rides: $', totalFares printString; cr.
Transcript show: '╚═════════════════════════════════════════╝'; cr.

"========== DEMONSTRATION 5: Display Driver Information =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  DRIVER COMPLETE INFORMATION'; cr.
Transcript show: '=================================================='; cr.
driver1 getDriverInfo.
Transcript cr.
driver2 getDriverInfo.

"========== DEMONSTRATION 6: Display Rider Information =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  RIDER COMPLETE INFORMATION'; cr.
Transcript show: '=================================================='; cr.
rider1 viewRides.
Transcript cr.
rider2 viewRides.

"========== SUMMARY =========="
Transcript cr.
Transcript show: '=================================================='; cr.
Transcript show: '  OOP PRINCIPLES DEMONSTRATED'; cr.
Transcript show: '=================================================='; cr; cr.
Transcript show: '1. ENCAPSULATION:'; cr.
Transcript show: '   - Private instance variables in Ride, Driver, and Rider classes'; cr.
Transcript show: '   - Public accessor methods control access to data'; cr.
Transcript show: '   - assignedRides and requestedRides are private collections'; cr; cr.
Transcript show: '2. INHERITANCE:'; cr.
Transcript show: '   - StandardRide, PremiumRide, and EconomyRide inherit from Ride'; cr.
Transcript show: '   - Child classes extend base class functionality'; cr.
Transcript show: '   - Reusability of common code through super calls'; cr; cr.
Transcript show: '3. POLYMORPHISM:'; cr.
Transcript show: '   - fare() method overridden in each subclass'; cr.
Transcript show: '   - rideDetails() method customized per ride type'; cr.
Transcript show: '   - Different ride types stored in single collection'; cr.
Transcript show: '   - Single message interface for multiple implementations'; cr; cr.
Transcript show: '=================================================='; cr.
Transcript show: 'Program completed successfully!'; cr.
Transcript show: '=================================================='; cr; cr.