require "test_helper"

class ProductTest < ActiveSupport::TestCase
def setup
    @product = Product.new
  end

  def new_product(image_url)
    Product.new(title:  "My Book Title",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end

  test "attribute should not be empty" do
    assert_not @product.valid?
    assert @product.errors[:title].any?
    assert @product.errors[:description].any?
    assert @product.errors[:price].any?
    assert @product.errors[:image_url].any?
  end

  test "price should be positive" do
    @product = Product.new(title:  "My Book Title",
                          description: "yyy",
                          image_url: "zzz.jpg")
    @product.price = -1
    assert_not @product.valid?
    assert_equal ["must be greater than or equal to 0.01"],
                 @product.errors[:price]

    @product.price = 0
    assert_not @product.valid?
    assert_equal ["must be greater than or equal to 0.01"],
                 @product.errors[:price]

    @product.price = 1
    assert @product.valid?
  end

  test "image url should be valid" do
    correct_url = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
      http://a.b.c/x/y/z/fred.gif https://a.b.c/x/y/z/fred.gif }
    correct_url.each do |image_url|
      assert new_product(image_url).valid?,
             "#{image_url} must be valid"
    end
  end

  test "image url should not be invalid" do
    incorrect_url = %w{ fred.doc fred.gif/more fred.gif.more }
    incorrect_url.each do |image_url|
      assert new_product(image_url).invalid?,
          "#{image_url} must be invalid"
    end
  end

  test "should be invalid withoud an unique title" do
    product_apple = Product.new(title:  products(:apple).title,
                                description: "yyy",
                                price: 5.9,
                                image_url: 'apple.jpg')
    assert_not product_apple.valid?
    assert_equal ["has already been taken"], product_apple.errors[:title]
  end
end
