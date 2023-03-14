use crate::garden::vegetables::Asparagus;
use std::fmt::Result;


pub mod garden;

fn main() {
    let plant = Asparagus {};
    println!("I'm growing {:?}!", plant);
}
