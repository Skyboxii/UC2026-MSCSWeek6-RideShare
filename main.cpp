#include <string>
#include <vector>
#include <iostream>
#include <iomanip>

using namespace std;

// ==================== BASE RIDE CLASS ====================

class Ride {
private:
    // Encapsulated attributes
    int rideID;
    string pickupLocation;
    string dropoffLocation;
    double distance;
    
protected:
    double baseFarePerMile;
    
public:
    // Constructor
    Ride(int id, string pickup, string dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), 
          distance(dist), baseFarePerMile(2.00) {}
    
    // Virtual destructor for proper cleanup
    virtual ~Ride() {}
    
    // Getters (Encapsulation - controlled access)
    int getRideID() const { return rideID; }
    string getPickupLocation() const { return pickupLocation; }
    string getDropoffLocation() const { return dropoffLocation; }
    double getDistance() const { return distance; }
    
    // Virtual methods for polymorphism
    virtual double fare() const {
        return distance * baseFarePerMile;
    }
    
    virtual void rideDetails() const {
        cout << "┌─────────────────────────────────────────┐" << endl;
        cout << "│ Ride ID: " << setw(30) << left << rideID << "│" << endl;
        cout << "│ Type: " << setw(33) << left << getRideType() << "│" << endl;
        cout << "│ Pickup: " << setw(31) << left << pickupLocation << "│" << endl;
        cout << "│ Dropoff: " << setw(30) << left << dropoffLocation << "│" << endl;
        cout << "│ Distance: " << setw(24) << left << (to_string(distance) + " miles") << "│" << endl;
        cout << "│ Fare: $" << setw(30) << left << fixed << setprecision(2) << fare() << "│" << endl;
        cout << "└─────────────────────────────────────────┘" << endl;
    }
    
    virtual string getRideType() const {
        return "Base Ride";
    }
};

// ==================== STANDARD RIDE CLASS ====================

class StandardRide : public Ride {
private:
    static constexpr double STANDARD_RATE = 2.50;
    
public:
    StandardRide(int id, string pickup, string dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {
        baseFarePerMile = STANDARD_RATE;
    }
    
    double fare() const override {
        return getDistance() * STANDARD_RATE;
    }
    
    void rideDetails() const override {
        cout << "┌─────────────────────────────────────────┐" << endl;
        cout << "│ STANDARD RIDE                           │" << endl;
        cout << "├─────────────────────────────────────────┤" << endl;
        cout << "│ Ride ID: " << setw(30) << left << getRideID() << "│" << endl;
        cout << "│ Pickup: " << setw(31) << left << getPickupLocation() << "│" << endl;
        cout << "│ Dropoff: " << setw(30) << left << getDropoffLocation() << "│" << endl;
        cout << "│ Distance: " << setw(24) << left << (to_string(getDistance()) + " miles") << "│" << endl;
        cout << "│ Rate: $" << setw(29) << left << (to_string(STANDARD_RATE) + "/mile") << "│" << endl;
        cout << "│ Fare: $" << setw(30) << left << fixed << setprecision(2) << fare() << "│" << endl;
        cout << "└─────────────────────────────────────────┘" << endl;
    }
    
    string getRideType() const override {
        return "Standard";
    }
};

// ==================== PREMIUM RIDE CLASS ====================

class PremiumRide : public Ride {
private:
    static constexpr double PREMIUM_RATE = 4.00;
    double luxuryFee;
    
public:
    PremiumRide(int id, string pickup, string dropoff, double dist, double fee = 5.0)
        : Ride(id, pickup, dropoff, dist), luxuryFee(fee) {
        baseFarePerMile = PREMIUM_RATE;
    }
    
    double fare() const override {
        return (getDistance() * PREMIUM_RATE) + luxuryFee;
    }
    
    void rideDetails() const override {
        cout << "┌─────────────────────────────────────────┐" << endl;
        cout << "│ ★ PREMIUM RIDE ★                        │" << endl;
        cout << "├─────────────────────────────────────────┤" << endl;
        cout << "│ Ride ID: " << setw(30) << left << getRideID() << "│" << endl;
        cout << "│ Pickup: " << setw(31) << left << getPickupLocation() << "│" << endl;
        cout << "│ Dropoff: " << setw(30) << left << getDropoffLocation() << "│" << endl;
        cout << "│ Distance: " << setw(24) << left << (to_string(getDistance()) + " miles") << "│" << endl;
        cout << "│ Premium Rate: $" << setw(21) << left << (to_string(PREMIUM_RATE) + "/mile") << "│" << endl;
        cout << "│ Luxury Fee: $" << setw(24) << left << fixed << setprecision(2) << luxuryFee << "│" << endl;
        cout << "│ Total Fare: $" << setw(24) << left << fare() << "│" << endl;
        cout << "└─────────────────────────────────────────┘" << endl;
    }
    
    string getRideType() const override {
        return "Premium";
    }
};

// ==================== ECONOMY RIDE CLASS ====================

class EconomyRide : public Ride {
private:
    static constexpr double ECONOMY_RATE = 1.75;
    double discount;
    
public:
    EconomyRide(int id, string pickup, string dropoff, double dist, double disc = 0.15)
        : Ride(id, pickup, dropoff, dist), discount(disc) {
        baseFarePerMile = ECONOMY_RATE;
    }
    
    double fare() const override {
        double baseFare = getDistance() * ECONOMY_RATE;
        return baseFare * (1.0 - discount);
    }
    
    void rideDetails() const override {
        cout << "┌─────────────────────────────────────────┐" << endl;
        cout << "│ ECONOMY RIDE                            │" << endl;
        cout << "├─────────────────────────────────────────┤" << endl;
        cout << "│ Ride ID: " << setw(30) << left << getRideID() << "│" << endl;
        cout << "│ Pickup: " << setw(31) << left << getPickupLocation() << "│" << endl;
        cout << "│ Dropoff: " << setw(30) << left << getDropoffLocation() << "│" << endl;
        cout << "│ Distance: " << setw(24) << left << (to_string(getDistance()) + " miles") << "│" << endl;
        cout << "│ Economy Rate: $" << setw(21) << left << (to_string(ECONOMY_RATE) + "/mile") << "│" << endl;
        cout << "│ Discount: " << setw(27) << left << (to_string(static_cast<int>(discount * 100)) + "%") << "│" << endl;
        cout << "│ Final Fare: $" << setw(24) << left << fixed << setprecision(2) << fare() << "│" << endl;
        cout << "└─────────────────────────────────────────┘" << endl;
    }
    
    string getRideType() const override {
        return "Economy";
    }
};

// ==================== DRIVER CLASS ====================

class Driver {
private:
    // Encapsulated attributes
    int driverID;
    string name;
    double rating;
    vector<Ride*> assignedRides;  // Private list of rides
    
public:
    // Constructor
    Driver(int id, string driverName, double initialRating = 5.0)
        : driverID(id), name(driverName), rating(initialRating) {}
    
    // Destructor
    ~Driver() {}
    
    // Public methods to access private data
    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
        cout << "✓ Ride #" << ride->getRideID() << " assigned to driver " << name << endl;
    }
    
    void getDriverInfo() const {
        cout << "\n╔═════════════════════════════════════════╗" << endl;
        cout << "║          DRIVER INFORMATION             ║" << endl;
        cout << "╠═════════════════════════════════════════╣" << endl;
        cout << "║ Driver ID: " << setw(28) << left << driverID << "║" << endl;
        cout << "║ Name: " << setw(33) << left << name << "║" << endl;
        cout << "║ Rating: " << setw(27) << left << (to_string(rating) + " / 5.0") << "║" << endl;
        cout << "║ Total Rides: " << setw(26) << left << assignedRides.size() << "║" << endl;
        cout << "║ Total Earnings: $" << setw(22) << left << fixed << setprecision(2) << getTotalEarnings() << "║" << endl;
        cout << "╚═════════════════════════════════════════╝" << endl;
        
        if (!assignedRides.empty()) {
            cout << "\nCompleted Rides:" << endl;
            for (size_t i = 0; i < assignedRides.size(); i++) {
                cout << "\n--- Ride " << (i + 1) << " ---" << endl;
                assignedRides[i]->rideDetails();
            }
        }
    }
    
    double getTotalEarnings() const {
        double total = 0.0;
        for (const auto& ride : assignedRides) {
            total += ride->fare();
        }
        return total;
    }
    
    int getTotalRides() const {
        return assignedRides.size();
    }
    
    string getName() const {
        return name;
    }
};

// ==================== RIDER CLASS ====================

class Rider {
private:
    // Encapsulated attributes
    int riderID;
    string name;
    vector<Ride*> requestedRides;  // Private list of rides
    
public:
    // Constructor
    Rider(int id, string riderName)
        : riderID(id), name(riderName) {}
    
    // Destructor
    ~Rider() {}
    
    // Public methods to access private data
    void requestRide(Ride* ride) {
        requestedRides.push_back(ride);
        cout << "✓ Ride #" << ride->getRideID() << " requested by " << name << endl;
    }
    
    void viewRides() const {
        cout << "\n╔═════════════════════════════════════════╗" << endl;
        cout << "║          RIDER INFORMATION              ║" << endl;
        cout << "╠═════════════════════════════════════════╣" << endl;
        cout << "║ Rider ID: " << setw(29) << left << riderID << "║" << endl;
        cout << "║ Name: " << setw(33) << left << name << "║" << endl;
        cout << "║ Total Rides: " << setw(26) << left << requestedRides.size() << "║" << endl;
        cout << "║ Total Spent: $" << setw(25) << left << fixed << setprecision(2) << getTotalSpent() << "║" << endl;
        cout << "╚═════════════════════════════════════════╝" << endl;
        
        if (!requestedRides.empty()) {
            cout << "\nRide History:" << endl;
            for (size_t i = 0; i < requestedRides.size(); i++) {
                cout << "\n--- Ride " << (i + 1) << " ---" << endl;
                requestedRides[i]->rideDetails();
            }
        }
    }
    
    double getTotalSpent() const {
        double total = 0.0;
        for (const auto& ride : requestedRides) {
            total += ride->fare();
        }
        return total;
    }
    
    string getName() const {
        return name;
    }
};

// ==================== HELPER FUNCTIONS ====================

void displayHeader(const string& title) {
    cout << "\n" << string(50, '=') << endl;
    cout << "  " << title << endl;
    cout << string(50, '=') << endl;
}

void demonstratePolymorphism(vector<Ride*>& rides) {
    displayHeader("POLYMORPHISM DEMONSTRATION");
    cout << "Calling fare() and rideDetails() polymorphically on different ride types:\n" << endl;
    
    double totalFares = 0.0;
    
    for (size_t i = 0; i < rides.size(); i++) {
        cout << "Ride " << (i + 1) << ":" << endl;
        rides[i]->rideDetails();  // Polymorphic call
        totalFares += rides[i]->fare();  // Polymorphic call
        cout << endl;
    }
    
    cout << "╔═════════════════════════════════════════╗" << endl;
    cout << "║ Total Fares from All Rides: $" << setw(10) << left << fixed << setprecision(2) << totalFares << "║" << endl;
    cout << "╚═════════════════════════════════════════╝" << endl;
}

// ==================== MAIN PROGRAM ====================

int main() {
    cout << "\n";
    cout << "╔═══════════════════════════════════════════════════╗" << endl;
    cout << "║                                                   ║" << endl;
    cout << "║        RIDE SHARING SYSTEM - C++                  ║" << endl;
    cout << "║   Demonstrating OOP Principles                    ║" << endl;
    cout << "║                                                   ║" << endl;
    cout << "╚═══════════════════════════════════════════════════╝" << endl;
    
    // ========== DEMONSTRATION 1: Creating Rides (Inheritance) ==========
    displayHeader("CREATING DIFFERENT RIDE TYPES");
    cout << "Demonstrating Inheritance: StandardRide, PremiumRide, and EconomyRide\n" << endl;
    
    // Create different types of rides
    StandardRide* ride1 = new StandardRide(101, "Downtown", "Airport", 15.5);
    PremiumRide* ride2 = new PremiumRide(102, "Hotel Plaza", "Convention Center", 8.2, 10.0);
    EconomyRide* ride3 = new EconomyRide(103, "Main St", "Oak Ave", 5.0, 0.20);
    StandardRide* ride4 = new StandardRide(104, "University", "Shopping Mall", 12.3);
    PremiumRide* ride5 = new PremiumRide(105, "Luxury Resort", "Restaurant District", 18.7, 15.0);
    
    cout << "✓ Created 5 rides of different types" << endl;
    
    // ========== DEMONSTRATION 2: Encapsulation with Driver ==========
    displayHeader("ENCAPSULATION - DRIVER CLASS");
    cout << "Demonstrating Encapsulation: Private attributes accessed through public methods\n" << endl;
    
    Driver driver1(501, "John Smith", 4.8);
    Driver driver2(502, "Sarah Johnson", 4.9);
    
    cout << "\nAdding rides to Driver: " << driver1.getName() << endl;
    driver1.addRide(ride1);
    driver1.addRide(ride2);
    driver1.addRide(ride3);
    
    cout << "\nAdding rides to Driver: " << driver2.getName() << endl;
    driver2.addRide(ride4);
    driver2.addRide(ride5);
    
    // ========== DEMONSTRATION 3: Encapsulation with Rider ==========
    displayHeader("ENCAPSULATION - RIDER CLASS");
    cout << "Demonstrating Encapsulation: Private ride history accessed through public methods\n" << endl;
    
    Rider rider1(701, "Alice Brown");
    Rider rider2(702, "Bob Wilson");
    
    cout << "\n" << rider1.getName() << " requesting rides:" << endl;
    rider1.requestRide(ride1);
    rider1.requestRide(ride3);
    
    cout << "\n" << rider2.getName() << " requesting rides:" << endl;
    rider2.requestRide(ride2);
    rider2.requestRide(ride4);
    rider2.requestRide(ride5);
    
    // ========== DEMONSTRATION 4: Polymorphism ==========
    // Store different ride types in a single vector using base class pointers
    vector<Ride*> allRides;
    allRides.push_back(ride1);
    allRides.push_back(ride2);
    allRides.push_back(ride3);
    allRides.push_back(ride4);
    allRides.push_back(ride5);
    
    demonstratePolymorphism(allRides);
    
    // ========== DEMONSTRATION 5: Display Driver Information ==========
    displayHeader("DRIVER COMPLETE INFORMATION");
    driver1.getDriverInfo();
    cout << "\n";
    driver2.getDriverInfo();
    
    // ========== DEMONSTRATION 6: Display Rider Information ==========
    displayHeader("RIDER COMPLETE INFORMATION");
    rider1.viewRides();
    cout << "\n";
    rider2.viewRides();
    
    // ========== SUMMARY ==========
    displayHeader("OOP PRINCIPLES DEMONSTRATED");
    cout << "\n1. ENCAPSULATION:" << endl;
    cout << "   - Private attributes in Ride, Driver, and Rider classes" << endl;
    cout << "   - Public methods (getters/setters) control access to data" << endl;
    cout << "   - assignedRides and requestedRides are private vectors" << endl;
    
    cout << "\n2. INHERITANCE:" << endl;
    cout << "   - StandardRide, PremiumRide, and EconomyRide inherit from Ride" << endl;
    cout << "   - Child classes extend base class functionality" << endl;
    cout << "   - Reusability of common code in base class" << endl;
    
    cout << "\n3. POLYMORPHISM:" << endl;
    cout << "   - Virtual fare() method overridden in each subclass" << endl;
    cout << "   - Virtual rideDetails() method customized per ride type" << endl;
    cout << "   - Base class pointers call appropriate derived methods at runtime" << endl;
    cout << "   - Single interface (Ride*) for multiple implementations\n" << endl;
    
    cout << string(50, '=') << endl;
    cout << "Program completed successfully!" << endl;
    cout << string(50, '=') << endl << endl;
    
    // Cleanup
    delete ride1;
    delete ride2;
    delete ride3;
    delete ride4;
    delete ride5;
    
    return 0;
}