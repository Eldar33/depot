require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success

    # ищется гиперссылки <а> в элементе с id="side", который содержится
    # в элементе с id="columns", таких элементов должно быть миниум 4 на странице
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', "Programming Ruby 1.9 & 2.0"
    assert_select '.price', /\$[,\d]+\.\d\d/

    #assert_select если 2ой аргумент число, то метод вернет число,
    #если строка, то она будет рассматриваться как ожидаемый результат 

  end

end
