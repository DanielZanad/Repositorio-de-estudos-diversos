mod enums;
mod structs;
mod tuple;
mod variables;

// Declare Car struct to describe vehicle with four named fields
struct Car {
    color: String,
    transmission: Transmission,
    convertible: bool,
    mileage: u32,
}

#[derive(PartialEq, Debug)]
// Declare enum for Car transmission type
enum Transmission {
    Manual,
    SemiAuto,
    Automatic,
}

fn main() {
    // We have orders for three new cars!
    // We'll declare a mutable car variable and reuse it for all the cars
    let transmission = Transmission::Automatic;
    let mut car = car_factory(String::from("Red"), transmission, false);
    println!("Car 1 = {}, {:?} transmission, convertible: {}, mileage: {}", car.color, car.transmission, car.convertible, car.mileage);

    car = car_factory(String::from("Silver"), Transmission::Automatic, true);
    println!("Car 2 = {}, {:?} transmission, convertible: {}, mileage: {}", car.color, car.transmission, car.convertible, car.mileage);

    car = car_factory(String::from("Yellow"), Transmission::SemiAuto, false);
    println!("Car 3 = {}, {:?} transmission, convertible: {}, mileage: {}", car.color, car.transmission, car.convertible, car.mileage); 
}

fn car_factory(color: String, transmission: Transmission, convertible: bool) -> Car {
    // Use the values of the input arguments
    // All new cars always have zero mileage
    return Car {
        color,
        transmission,
        convertible,
        mileage: 0,
    };

}

fn goodbye(message: &str) {
    println!("\n{}", message);
}

fn divide_by_5(num: u32) -> u32 {
    if num == 0 {
        // return early
        return 0;
    }
    num / 5
}
