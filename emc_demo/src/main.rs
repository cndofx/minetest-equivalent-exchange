use data::{ITEMS, RECIPES};

mod data;

fn main() {
    for item in ITEMS.iter() {
        println!("{item}");
    }
    for recipes in RECIPES.iter() {
        dbg!(&recipes);
    }
}
