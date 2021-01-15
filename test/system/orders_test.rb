require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Address", with: @order.address
    fill_in "Email", with: @order.email
    fill_in "Name", with: @order.name
    fill_in "Pay type", with: @order.pay_type
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "check routing number" do
    visit store_index_url

     # кликаем по первой кнопке 'Add to Cart'
    click_on 'Add to Cart', match: :first

    click_on 'Checkout'

    fill_in 'order_name', with: 'Dave Thomas'
    fill_in 'order_address', with: '123 Main Street'
    fill_in 'order_email', with: 'dave@example.com'

    # *****************************
    # ********* Check *************
    # *****************************
    # Проверяем предположение, что полей еще нет на странице
    # любой элемент с id 
    assert_no_selector "#order_routing_number"
    assert_no_selector "#order_account_number"

    # Выбираем значение 'Check' из поля 'Pay Type' 
    select 'Check', from: 'Pay Type'

    # Проверяем, что поля появилось
    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"

    # ***********************************
    # ********* Credit card *************
    # ***********************************
    # Убираем выбор
    select 'Select a payment method', from: 'Pay Type'

    # Проверяем, что полей с id "order_credit_card_number" и "order_expiration_date" нет
    assert_no_selector "#order_credit_card_number"    
    assert_no_selector "#order_expiration_date" 

    select 'Credit card', from: 'Pay Type'
    # Проверяем, что поля появились
    assert_selector "#order_credit_card_number"    
    assert_selector "#order_expiration_date"

    # ***********************************
    # ********* Credit card *************
    # ***********************************
     # Убираем выбор
    select 'Select a payment method', from: 'Pay Type'

    assert_no_selector "#order_po_number"    

    select 'Purchase order', from: 'Pay Type'

    assert_selector "#order_po_number"    
   

  end
end
