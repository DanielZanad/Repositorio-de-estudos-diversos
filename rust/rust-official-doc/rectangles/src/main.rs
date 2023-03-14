#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        return self.width * self.height;
    }

    fn width(&self) -> bool {
        self.width > 0
    }

    fn can_hold(self: &Self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }

    fn square(size: u32) -> Self {
        Self {
            width: size,
            height: size,
        }
    }
}

fn main() {
    let rectangle = Rectangle {
        width: 30,
        height: 50,
    };

    println!(
        "The area of the rectangle is {} square pixels. ",
        area(&rectangle)
    );

    println!(
        "The area of the rectangle is {} square pixels. ",
        rectangle.area()
    );

    if rectangle.width() {
        println!(
            "the rectanlge has a nonzero width; it is {} ",
            rectangle.width
        )
    }

    println!("rectangle is {:?}", rectangle);

    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };
    let rect2 = Rectangle {
        width: 10,
        height: 40,
    };
    let rect3 = Rectangle {
        width: 60,
        height: 45,
    };

    println!("Can rect1 hold rect2? {}", rect1.can_hold(&rect2));
    println!("Can rect1 hold rect3? {}", rect1.can_hold(&rect3));

    let square = Rectangle::square(5);
}

fn area(rectangle: &Rectangle) -> u32 {
    rectangle.height * rectangle.width
}
