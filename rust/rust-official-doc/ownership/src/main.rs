
mod stringSlices;

fn main() {
    let x = "fds";

    let mut s = String::from("hello");
    let s1 = String::from("hello");

    change(&mut s);
    let len = calculate_length(&s1);

    println!("The length of '{}' is {}", s1, len);
    
    println!("{}", s);
    
    let mut r1 = &s;
    r1 = &s1;
    
    println!("{}", r1);

    stringSlices::main();
}

fn calculate_length(s: &String) -> usize{
    s.len()
}

fn change(s: &mut String) {
    s.push_str(", world");
}