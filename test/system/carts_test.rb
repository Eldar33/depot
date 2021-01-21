require "application_system_test_case"

class CartsTest < ApplicationSystemTestCase
  setup do
    @cart = carts(:one)
  end

  test "visiting the index" do
    visit carts_url
    assert_selector "h1", text: "Carts"
  end

  test "creating a Cart" do
    visit carts_url
    click_on "New Cart"

    click_on "Create Cart"

    assert_text "Cart was successfully created"
    # click_on "Back"
  end

  test "updating a Cart" do
    visit carts_url
    click_on "Edit", match: :first

    click_on "Update Cart"

    assert_text "Cart was successfully updated"
    # click_on "Back"
  end

  test "destroying a Cart" do
    visit carts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cart was successfully destroyed"
  end

  # homework
  # Проверяем кнопку 'Add To Cart' 
  test "adding to cart and empty cart" do
    visit store_url
    
    assert_no_text "Your Cart"
    click_on "Add to Cart", match: :first   
    assert_text "Your Cart"
    assert_selector ".line-item-highlight"

    page.accept_confirm do
      click_on 'Empty cart', match: :one
    end
    assert_no_text "Your Cart"


         
  end
end
