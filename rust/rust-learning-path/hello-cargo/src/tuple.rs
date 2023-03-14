use crate::tuple;

struct Student {
    name: String,
    level: u8,
    remote: bool,
}

pub(crate) fn main() {
    let tuple_e = ('E', 5i32, true);
    let tuple_b = (
        'E',
        Student {
            name: String::from("Walter white"),
            level: 2,
            remote: true,
        },
        true,
    );

    println!(
        "Is {} the {}th letter of the alphabet? {}",
        tuple_e.0, tuple_e.1, tuple_e.2,
    );

    println!("{}, level {}. Remote: {}.", tuple_b.1.name, tuple_b.1.level, tuple_b.1.remote);
}
