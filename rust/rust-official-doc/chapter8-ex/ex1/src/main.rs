use std::collections::HashMap;

fn main() {
    let mut list = vec![1, 2, 2, 4, 5, 3, 2, 3, 4, 2];
    let mut mode = HashMap::new();

    list.sort();

    // mode.entry("median").or_insert(list.len() / 2);

    println!("{:?}", mode);

    for &number in &list {
        let count = mode.entry(number).or_insert(0);
        *count += 1;
    }

    let mut aux: (i32, i32) = (0, 0);
    for (&key, &value) in &mode {
        if value >= aux.1 {
            aux.0 = key;
            aux.1 = value;
        }
    }

    println!("median: {}", list[list.len() / 2]);
    println!("mode: {:?}", mode.get(&aux.0).copied().unwrap_or(0));
}
