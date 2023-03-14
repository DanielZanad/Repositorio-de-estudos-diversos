
// Classical struct
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}

// Tuple struct
struct Color(i32, i32, i32);
struct Point(i32, i32, i32);

// unit-like structs
struct AlwaysEqual;

fn main() {
    let  user1 = User {
        email: String::from("walter@email.com"),
        username: String::from("walter"),
        active: true,
        sign_in_count: 1,
    };

    let user2 = User {
        email: String::from("walter@whiter.com"),
        ..user1
    };

    let subject = AlwaysEqual;

    let black = Color(0,0,0);
    let a = black.0;
    let origin  = Point(0,0,0);


    println!("{}", user1.active);
}

fn build_user(email: String, username: String) -> User {
    User {
        email,
        username,
        active: true,
        sign_in_count: 1,
    }
}
