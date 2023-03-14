fn main() {
    let words = String::from("now i become death, the destroyer of worlds");

    let mut result = String::from("");

    for word in &mut words.split_whitespace() {
        if word.starts_with(['a', 'e', 'i', 'o', 'u']) {
            result.push_str(&word);
            result.push_str("-");
            result.push_str("hay ");
        } else {
            let mut aux = String::from("");
            let mut caux = 0;
            for l in word.chars() {
                if caux >= 1 {
                    aux.push(l);
                }
                caux += 1;
            }
            result.push_str(&aux);
            result.push_str("-");
            result.push_str("fay ");
        }
    }

    println!("{}", result);
}
