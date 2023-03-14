fn main() {
    println!("Hello, world!");

    another_function(5, 'h');

    /*
     * Statements => Declarações
     * São instruções para performar alguma ação e não retornam um valor
     *
     * Expressions => Expressões
     * Expressões "avaliam" retornando um valor
     */

    // Statement
    let mut y = 6;

    let x = y = 4;

    // Expression
    let z = {
        let x = 3;
        x + 1
    };

    let five = five();

    println!("The value of x is: {five}");

    let x = plus_one(5);

    println!("The value of x is: {x}");
}

fn five() -> i32 {
    return 5;
}

fn plus_one(x: i32) -> i32 {
    x + 1
}

fn another_function(value: i32, unit_label: char) {
    println!("The measurement is: {value}{unit_label}");
}
