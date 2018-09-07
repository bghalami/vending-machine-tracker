require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end
  scenario 'they see the name all snacks associated with vending machine and their price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burgers = dons.snacks.create!(name: "White Castle Burger", price: 3.50)
    pop_rocks = dons.snacks.create!(name: "Pop Rocks", price: 1.50)
    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 2.50)

    visit machine_path(dons)

    expect(page).to have_content("#{burgers.name}: $#{burgers.pricef}")
    expect(page).to have_content("#{pop_rocks.name}: $#{pop_rocks.pricef}")
    expect(page).to have_content("#{hot_cheetos.name}: $#{hot_cheetos.pricef}")
  end
  scenario 'user can see the average price of all snacks for machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    burgers = dons.snacks.create!(name: "White Castle Burger", price: 3.00)
    pop_rocks = dons.snacks.create!(name: "Pop Rocks", price: 1.00)
    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 2.00)

    visit machine_path(dons)

    expect(page).to have_content("Average Price: $2.00")
  end
end
