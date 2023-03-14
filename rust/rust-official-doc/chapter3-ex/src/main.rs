fn main() {
    let fah = convert_celsius_to_fahrenheit(30.0);
    println!("Fahrenheit {fah}");

    let cel = convert_fahrenheit_to_celsius(86.00);
    println!("Celsius {cel}");

    let fibo = generate_fibonacci(4);
    println!("Fibo: {fibo}")
}

fn generate_fibonacci(number: i32) -> i32 {
    return if number <= 1 {
        number
    } else {
        generate_fibonacci(number - 1) + generate_fibonacci(number - 2)
    };
}

fn convert_fahrenheit_to_celsius(fahrenheit: f64) -> f64 {
    (fahrenheit - 32.00) * 5.0 / 9.0
}

fn convert_celsius_to_fahrenheit(celsius: f64) -> f64 {
    celsius * 9.0 / 5.0 + 32.0
}

fn print_christmas() -> () {
    
    let my_true_love = "my true love sent to me";
    let mut on_the = "On the first day of Christmas,";

    for element in 1..12 {
        println!("{on_the}");
        println!("{my_true_love}");
    }
}
