mod employee;

use std::io::{self, Write};

use employee::Employee;

fn main() {
    let mut employee_list: Vec<Employee> = Vec::new();

    loop {
        println!("(1) add new employeer: ");
        println!("(2) see the list: ");
        println!("(3) quit: ");

        let mut input = String::new();

        io::stdin()
            .read_line(&mut input)
            .expect("Failed to read line");

        let option: u32 = match input.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match option {
            1 => {
                println!("Add a new employee (Add 'name' to 'department')");

                let mut text = String::new();

                io::stdin()
                    .read_line(&mut text)
                    .expect("Failed to read line");

                let employee = create_name_and_department(text);

                employee_list.push(employee);
            }

            2 => {
                println!("(1) show all people in a department");
                println!("(2) show all people in the company by deparment");

                let mut input = String::new();

                io::stdin()
                    .read_line(&mut input)
                    .expect("Failed to read line");

                let option: u32 = match input.trim().parse() {
                    Ok(num) => num,
                    Err(_) => continue,
                };

                match option {
                    1 => {
                        let mut department = String::new();

                        io::stdin()
                            .read_line(&mut department)
                            .expect("Failed to read line");

                        show_all_people_in_a_department(&department, &employee_list)
                    }
                    2 => show_all(&employee_list),
                    _ => ()
                }
            }

            3 => break,

            _ => break,
        }
    }

    let x = Employee {
        name: String::from("Walter"),
        department: String::from("Teacher"),
    };
}

fn show_all(list: &Vec<Employee>) {
    for item in list {
        println!("Employee name: {}", item.name);
        println!("Employee department: {}", item.department);
    }
}

fn create_name_and_department(text: String) -> Employee {
    let mut count = 0;
    let mut name = "";
    let mut department = "";

    for word in text.split_whitespace() {
        match count {
            1 => name = word,
            3 => department = word,
            _ => (),
        }
        count += 1
    }

    return Employee {
        name: String::from(name),
        department: String::from(department),
    };
}

fn show_all_people_in_a_department(department: &String, employee_list: &Vec<Employee>) {
    let mut aux_list: Vec<Employee> = Vec::new();

    for employee in employee_list {
        if department
            .trim()
            .to_lowercase()
            .eq(&employee.department.trim().to_lowercase())
        {
            let new_employee = Employee {
                name: employee.name.clone(),
                department: employee.department.clone(),
            };

            aux_list.push(new_employee);
        }
    }

    aux_list.sort_by(|x, y| x.name.cmp(&y.name));

    for item in &aux_list {
        println!("Name: {} ", item.name);
        println!("Department: {} ", item.department);
    }
}
