pub(crate) fn main() {
    // enum WebEvent {
    //     // Um enum variant pode ser como um struct sem campos or tipos da dados
    //     WELoad,
    //     // Um enum variant pode ser como uma estrutura de tupla com tipos de dados mas sem campos com nome
    //     WEKeys(String, char),
    //     // Um enum variant pode ser como uma estrutura classica com campos nomeados e seus tipos de dados
    //     WEClick { x: i64, y: i64 },
    // }

    // Define uma estrutura de tupla
    #[derive(Debug)]
    struct KeyPress(String, char);

    // Define uma estrutura classica
    #[derive(Debug)]
    struct MouseClick {
        x: i64,
        y: i64,
    }

    // Redefine as variantes do enum para usar os dados das novas estruturas
    // Atualiza a pagina que Carrega as variantes para terem o tipo booleano
    #[derive(Debug)]
    enum WebEvent {
        WELoad(bool),
        WEClick(MouseClick),
        WEKeys(KeyPress),
    }

    let we_load = WebEvent::WELoad(true);

    // Instancia a struct MouseClick e adiciona sua coordenadas
    let click = MouseClick { x: 100, y: 250 };

    // Coloca o WEClick variante para usar os dados na struct click
    let we_click = WebEvent::WEClick(click);

    // instancia a tupla KeyPress e adiciona os valores para das chaves
    let keys = KeyPress(String::from("Ctrl+"), 'N');

    // Coloca o WEKeys variante para usar os dados nas chaves da tupla
    let we_key = WebEvent::WEKeys(keys);

    println!("\nWebEvent enum structure: \n\n {:#?} \n\n {:#?} \n\n {:#?} ", we_load, we_click, we_key);

}
