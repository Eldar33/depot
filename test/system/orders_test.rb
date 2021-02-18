require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit store_url

    click_on "Add to Cart", match: :first
    click_on "Checkout"

    fill_in "Address", with: @order.address
    fill_in "E-mail", with: @order.email
    fill_in "Name", with: @order.name

    select @order.pay_type, from: "Pay with" 

    click_on "Place Order"
    assert_text "Thank you for your order"
    

    # visit orders_url
    # click_on "New Order"

    # fill_in "Address", with: @order.address
    # fill_in "Email", with: @order.email
    # fill_in "Name", with: @order.name
    # fill_in "Pay type", with: @order.pay_type
    # click_on "Create Order"

    # assert_text "Order was successfully created"
    # click_on "Back"
  end

  # test "updating a Order" do
  #   visit orders_url
  #   click_on "Edit", match: :first

  #   fill_in "Address", with: @order.address
  #   fill_in "Email", with: @order.email
  #   fill_in "Name", with: @order.name
  #   select @order.pay_type, from: "Pay type" 
  #   click_on "Place Order"

  #   assert_text "Order was successfully updated"
  #   click_on "Back"
  # end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end

  test "check routing number" do

    LineItem.delete_all
    Order.delete_all

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
    select 'Check', from: 'Pay with'

    # Проверяем, что поля появилось
    assert_selector "#order_routing_number"
    assert_selector "#order_account_number"

    fill_in "Routing #", with: "123456"
    fill_in "Account #", with: "987564"

    # Метод perform_enqueued_jobs выполнит все задания в очереди,
    # которые будут помещены в нее в переданном блоке
    perform_enqueued_jobs do
        click_button "Place Order"
    end

    orders = Order.all
    assert_equal 1, orders.size

    order = orders.first

    assert_equal "Dave Thomas", order.name
    assert_equal "123 Main Street", order.address
    assert_equal "dave@example.com", order.email
    assert_equal "Check", order.pay_type
    assert_equal 1, order.line_items.size

    # В тестовом окружении ActionMailer на самом деле не отправляет
    # почту, а помещает ее в массив ActionMailer::Base.deliveries
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Sam Ruby <depot@example.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Confirmation", mail.subject

    # ***********************************
    # ********* Credit card *************
    # ***********************************
    # Убираем выбор
    # select 'Select a payment method', from: 'Pay Type'

    # Проверяем, что полей с id "order_credit_card_number" и "order_expiration_date" нет
    # assert_no_selector "#order_credit_card_number"    
    # assert_no_selector "#order_expiration_date" 

    # select 'Credit card', from: 'Pay Type'
    # Проверяем, что поля появились
    # assert_selector "#order_credit_card_number"    
    # assert_selector "#order_expiration_date"

    # ***********************************
    # ********* Credit card *************
    # ***********************************
     # Убираем выбор
    # select 'Select a payment method', from: 'Pay Type'

    # assert_no_selector "#order_po_number"    

    # select 'Purchase order', from: 'Pay Type'

    # assert_selector "#order_po_number"    
   

  end
end
