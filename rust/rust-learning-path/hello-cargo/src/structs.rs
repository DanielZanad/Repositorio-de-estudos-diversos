// Struct classico com campos nomeados
struct Student {
    name: String,
    level: u8,
    remote: bool,
}

// Tuple struct com tipos de dados somente
struct Grades(char, char, char, char, f32);

// Unit struct
struct Unit;

pub(crate) fn main() {
    // Instanciando classic struct, especificando os tipos em ordem aletoria, ou uma ordem especifica
    let user_1 = Student {
        remote: true,
        level: 2,
        name: String::from("Constance Sharma"),
    };
    let user_2 = Student {
        name: "Walter White".to_string(),
        remote: false,
        level: 50,
    };

    // Instanciando tuple structs, passa o valor na mesma ordem que os tipos são definidos
    let mark_1 = Grades('A', 'A', 'B', 'A', 3.75);
    let mark_2 = Grades('B', 'A', 'A', 'C', 3.25);

    println!(
        "{}, level {}. Remote: {}. Grades: {}, {}, {}, {}. Average: {}",
        user_1.name, user_1.level, user_1.remote, mark_1.0, mark_1.1, mark_1.2, mark_1.3, mark_1.4
    );
    println!(
        "{}, level {}. Remote: {}. Grades: {}, {}, {}, {}. Average: {}",
        user_2.name, user_2.level, user_2.remote, mark_2.0, mark_2.1, mark_2.2, mark_2.3, mark_2.4
    );
}
