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
        map.entry(recipe.output.item)
            .or_insert(Vec::new())
            .push(recipe);
    }
    map
});

pub static DEFAULT_EMC: Lazy<HashMap<&str, i32>> = Lazy::new(|| {
    let mut map = HashMap::new();
    map.insert("default:cobble", 1);
    map.insert("default:diamond", 8192);
    map
});

pub static CUSTOM_EMC: Lazy<HashMap<&str, i32>> = Lazy::new(|| {
    let mut map = HashMap::new();
    map.insert("default:axe_steel", 1234);
    map
});

#[derive(Debug, Deserialize)]
pub struct Recipe<'a> {
    pub items: Option<Vec<Option<&'a str>>>,
    pub method: &'a str,
    // pub output: &'a str,
    // #[serde(deserialize_with = "output")]
    // pub output: Output,
    pub output: Output<'a>,
    #[serde(rename = "type")]
    pub recipe_type: &'a str,
    #[serde(skip)]
    pub width: u8,
}

#[derive(Debug, Deserialize)]
#[serde(from = "OutputStr")]
pub struct Output<'a> {
    pub item: &'a str,
    pub count: u8,
}

#[derive(Deserialize)]
struct OutputStr<'a> {
    s: &'a str,
}

// fn output<'de: 'static, D: Deserializer<'de>>(deserializer: D) -> Result<Output, D::Error> {
//     let s: &str = Deserialize::deserialize(deserializer)?;
//     let mut split = s.split(' ');
//     let item = split.next().unwrap();
//     let count = split.next().unwrap_or("1").parse::<u8>().unwrap();

//     Ok(Output { item, count })
// }

impl<'a> From<OutputStr<'a>> for Output<'a> {
    fn from(value: OutputStr<'a>) -> Self {
        let mut split = value.s.split(' ');
        let item = split.next().unwrap();
        let count = split.next().unwrap_or("1").parse::<u8>().unwrap();
        Output { item, count }
    }
}
