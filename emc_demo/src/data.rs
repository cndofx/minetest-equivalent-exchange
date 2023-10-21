use std::collections::HashMap;

use once_cell::sync::Lazy;
use serde::{Deserialize, Deserializer};

pub const RAW_ITEMS: &str = include_str!("../../dumped/items.txt");
pub const RAW_RECIPES: &str = include_str!("../../dumped/recipes.txt");

pub static ITEMS: Lazy<Vec<&str>> = Lazy::new(|| RAW_ITEMS.lines().collect());
pub static RECIPES: Lazy<HashMap<&str, Vec<Recipe>>> = Lazy::new(|| {
    let mut map = HashMap::new();
    // only works because the json is minified to one line per object
    for line in RAW_RECIPES.lines() {
        let recipe: Recipe = serde_json::from_str(line).unwrap();
        map.entry(recipe.output).or_insert(Vec::new()).push(recipe);
    }
    map
});

#[derive(Debug, Deserialize)]
pub struct Recipe<'a> {
    pub items: Option<Vec<Option<&'a str>>>,
    pub method: &'a str,
    pub output: &'a str,
    #[serde(rename = "type")]
    pub recipe_type: &'a str,
    #[serde(deserialize_with = "width")]
    pub width: u8,
}

fn width<'de, D: Deserializer<'de>>(deserializer: D) -> Result<u8, D::Error> {
    let num: f32 = Deserialize::deserialize(deserializer)?;
    Ok(num as u8)
}
