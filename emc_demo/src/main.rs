use std::{collections::HashMap, default};

use data::{ITEMS, RECIPES};

use crate::data::{CUSTOM_EMC, DEFAULT_EMC};

mod data;

type Cache = HashMap<&'static str, i32>;

fn main() {
    let mut cache: Cache = HashMap::new();

    // dbg!(get_emc_for("default:diamond", &mut cache));
    // dbg!(get_emc_for("default:diamondblock", &mut cache));
    // dbg!(get_emc_for("default:furnace", &mut cache));
    // dbg!(get_emc_for("default:axe_diamond", &mut cache));

    for recipe in RECIPES.iter() {
        println!("{recipe:#?}");
    }
}

fn get_emc_for(itemstring: &'static str, mut cache: &mut Cache) -> i32 {
    println!("\n\ngetting emc for '{itemstring}'");
    // make sure this item exists

    // hack to make dealing with groups easier
    match itemstring {
        "group:stone" => return get_emc_for("default:stone", &mut cache),
        "group:stick" => return get_emc_for("default:stick", &mut cache),
        _ => {}
    }

    if !ITEMS.contains(&itemstring) {
        println!("item doesnt exist");
        return -1;
    }

    // check if this item has a cached emc value
    if let Some(value) = cache.get(itemstring) {
        println!("emc of {value} found in cache");
        return *value;
    }

    // check if this item has a custom emc value
    if let Some(value) = CUSTOM_EMC.get(itemstring) {
        println!("emc of {value} found in CUSTOM_EMC");
        cache.insert(itemstring, *value);
        return *value;
    }

    // check if this item has a default emc value
    if let Some(value) = DEFAULT_EMC.get(itemstring) {
        println!("emc of {value} found in DEFAULT_EMC");
        cache.insert(itemstring, *value);
        return *value;
    }

    // no emc found, calculate from crafting components
    println!("no emc found, calculating...");
    let mut lowest_total_emc = -1;
    let Some(recipes) = RECIPES.get(itemstring) else {
        cache.insert(itemstring, -1);
        return -1;
    };
    // for every recipe that creates this item
    for recipe in recipes {
        let mut total_emc = 0;
        let mut all_ingredients_have_emc = true;
        dbg!(&recipe);
        if let Some(ingredients) = &recipe.items {
            for ingredient in ingredients {
                if let Some(ingredient) = ingredient {
                    let emc = get_emc_for(ingredient, &mut cache);
                    if emc > 0 {
                        total_emc += emc;
                    } else {
                        all_ingredients_have_emc = false;
                    }
                }
            }
        }
        total_emc = total_emc / recipe.output.count as i32;
        if all_ingredients_have_emc
            && total_emc > 0
            && (total_emc < lowest_total_emc || lowest_total_emc == -1)
        {
            lowest_total_emc = total_emc;
        }
    }
    // for recipes in RECIPES.get(itemstring) {
    //     let mut total_emc = 0;
    //     let mut all_ingredients_have_emc = true;
    //     dbg!(recipe);
    //     for ingredient in recipe.
    // }

    // todo!()
    println!("calculated emc value of {lowest_total_emc} for {itemstring}");
    cache.insert(itemstring, lowest_total_emc);
    lowest_total_emc
}
