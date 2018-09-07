require 'rails_helper'

describe 'user visits snack show page' do
  it 'should show a price for the snack' do
    owner1 = Owner.create(name: "Sam's Snacks")
    dons  = owner1.machines.create(location: "Don's Mixed Drinks")
    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 2.00)
    burgers = dons.snacks.create!(name: "White Castle Burger", price: 3.00)
    pop_rocks = dons.snacks.create!(name: "Pop Rocks", price: 1.00)
      # average price is 2.00

    owner2 = Owner.create(name: "Tims's Snacks")
    bens  = owner2.machines.create(location: "Ben's Mixed Drinks")
    twinkies = bens.snacks.create!(name: "Twinkies", price: 6.00)
    bens.snacks << hot_cheetos
    bens.snacks << burgers
    bens.snacks << pop_rocks
      # average price is 3.00

    owner3 = Owner.create(name: "Jim's Snacks")
    sarahs  = owner3.machines.create(location: "Sarahs's Mixed Drinks")
    sarahs.snacks << hot_cheetos
    sarahs.snacks << twinkies
      # average price is 4.00

    visit snack_path(hot_cheetos)

    expect(page).to have_content("Price: $#{hot_cheetos.pricef}")
  end
  it "should show a list of locations and vending machines that have how many types of snacks and average price" do
    owner1 = Owner.create(name: "Sam's Snacks")
    dons  = owner1.machines.create(location: "Don's Mixed Drinks")
    hot_cheetos = dons.snacks.create!(name: "Hot Cheetos", price: 2.00)
    burgers = dons.snacks.create!(name: "White Castle Burger", price: 3.00)
    pop_rocks = dons.snacks.create!(name: "Pop Rocks", price: 1.00)
      # average price is 2.00

    owner2 = Owner.create(name: "Tims's Snacks")
    bens  = owner2.machines.create(location: "Ben's Mixed Drinks")
    twinkies = bens.snacks.create!(name: "Twinkies", price: 6.00)
    bens.snacks << hot_cheetos
    bens.snacks << burgers
    bens.snacks << pop_rocks
      # average price is 3.00

    owner3 = Owner.create(name: "Jim's Snacks")
    sarahs  = owner3.machines.create(location: "Sarahs's Mixed Drinks")
    sarahs.snacks << hot_cheetos
    sarahs.snacks << twinkies
      # average price is 4.00

    visit snack_path(hot_cheetos)

    expect(page).to have_content("Locations:")
    expect(page).to have_content("#{dons.location} (3 kinds of snacks, average price of $2.00)")
    expect(page).to have_content("#{bens.location} (4 kinds of snacks, average price of $3.00)")
    expect(page).to have_content("#{sarahs.location} (2 kinds of snacks, average price of $4.00)")
  end
end
