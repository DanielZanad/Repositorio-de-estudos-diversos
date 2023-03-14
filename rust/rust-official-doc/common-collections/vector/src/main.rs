enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}

fn main() {
    // Creating a vector with the "constructor" from Vec
    let v:Vec<i32> = Vec::new();
    let v = vec![1,2,3];

    let mut v = Vec::new();

    v.push(1);
    v.push(2);
    v.push(3);

    let v = vec![1,23,4,5];

    let third = &v[2];
    println!("The third element is {third}");

    let third = v.get(2);
    match third {
        Some(third) => println!("The third element is {third}"),
        None => println!("There is no third element")
    }


    let v = vec![100, 32, 57];
    for i in &v {
        println!("{i}");
    }

    let row = vec![
        SpreadsheetCell::Int(3),
        SpreadsheetCell::Text(String::from(
            "blue"
        )),
        SpreadsheetCell::Float(3.5),
    ];

}
