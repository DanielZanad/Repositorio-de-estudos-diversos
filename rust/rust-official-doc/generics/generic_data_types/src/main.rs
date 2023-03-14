fn main() {
    let number_list = vec![34, 50, 25, 100, 65];

    let result = largest(&number_list);
    println!("The largest number is {}", result);

    let char_list = vec!['y', 'm', 'a', 'q'];

    let result = largest(&char_list);
    println!("The largest char is {}", result);

    let integer = Point { x: 5, y: 6 };
    println!("integer.x = {}", integer.x());
}

// Generic signature in an enum
enum Option<T> {
    Some(T),
    None,
}

// Generic signature in a struct
struct Point<T> {
    x: T,
    y: T,
}

// Generics signature inside a struct method
impl<S> Point<S> {
    fn x(&self) -> &S {
        &self.x
    }
}

// Implementing a method with `Point<f32>`
// Meaning that only types instances of that type will have this method
impl Point<f32> {
    fn distance_from_origin(&self) -> f32 {
        (self.x.powi(2) + self.y.powi(2).sqrt())
    }
}

// Generics signature in a function
fn largest<T: std::cmp::PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];

    for item in list {
        if item > largest {
            largest = item;
        }
    }

    largest
}
