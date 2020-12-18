require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success

    assert_select ".list_description", 3
    assert_select ".list_actions a", 9
    assert_select "a", "New product"

  end

  test "should get new" do
    get new_product_url
    assert_response :success

    assert_select "form .field", 4

    assert_select "form" do |element|
      assert element.attr("action").value == "/products"
    end

    assert_select "form .actions input" do |element|
      assert element.attr("type").value == "submit"
      assert element.attr("name").value == "commit"
      assert element.attr("value").value == "Create Product"
    end

  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: "#{@product.title}MustUnique" } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { description: @product.description, image_url: @product.image_url, price: @product.price, title: @product.title } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
