Given /^I am on the puppy adoption site$/ do
  # @browser.goto "http://puppies.herokuapp.com"
  visit HomePage
end

When(/^I press the View Details button for "(.+)"$/) do |puppy_name|
  # @browser.button(:value => 'View Details', :index => puppy_number.to_i - 1).click
  # @home_page.adopt_puppy puppy_number.to_i
  on(HomePage).adopt puppy_name
  
  # @details = DetailsPage.new @browser
end

When /^I press the Adopt Me button$/ do
  # @browser.button(:value => 'Adopt Me!').click
  # @details.add_to_cart
  on(DetailsPage).add_to_cart
  # @shopping_cart = ShoppingCartPage.new @browser
end

When /^I press the Adopt Another Puppy button$/ do
  # @browser.button(:value => 'Adopt Another Puppy').click
  # @shopping_cart.continue_shopping
  on(ShoppingCartPage).continue_shopping
end

When /^I press the Complete the Adoption button$/ do
  # @browser.button(:value => 'Complete the Adoption').click
  # @shopping_cart.proceed_to_checkout
  on(ShoppingCartPage).proceed_to_checkout
   # @checkout = CheckoutPage.new @browser
end

When /^I enter "(.+)" in the name field$/ do |name|
  # @browser.text_field(:id => 'order_name').set(name)
  # @checkout.name = name
  on(CheckoutPage).name = name
end

When /^I enter "([^\"]*)" in the address field$/ do |address|
  # @browser.text_field(:id => 'order_address').set(address)
    on(CheckoutPage).address = address
end

When /^I enter "([^\"]*)" in the email field$/ do |email|
  # @browser.text_field(:id => 'order_email').set(email)
  on(CheckoutPage).email = email
end

When /^I select "([^\"]*)" from the pay type dropdown$/ do |pay_type|
  # @browser.select_list(:id => 'order_pay_type').select(pay_type)
  on(CheckoutPage).pay_type = pay_type
end

When /^I press the Place Order button$/ do
  # @browser.button(:value => 'Place Order').click
  on(CheckoutPage).place_order
end

Then /^I should see "([^\"]*)"$/ do |expected|
  # @browser.text.should include expected
   @current_page.text.should include expected
end

Then /^I should see "([^\"]*)" for the name on (line item \d+)$/ do |name, line_item|
  # row = (line_item.to_i - 1) * 6
  # @browser.table(:index => 0)[row][1].text.should include name
  on(ShoppingCartPage).name_for_line_item(line_item).should include name
end

When /^I should see "(.+)" as the subtotal for (line item \d+)$/ do |subtotal, line_item|
  # row = (line_item.to_i - 1) * 6
  # @browser.table(:index => 0)[row][3].text.should == subtotal
   on(ShoppingCartPage).subtotal_for_line_item(line_item) == subtotal
end

When /^I should see "([^\"]*)" as the shopping cart total$/ do |total|
  # @browser.td(:class => 'total_cell').text.should == total
   on(ShoppingCartPage).cart_total.should == total
end


When(/^I checkout using:$/) do |table|
  on(CheckoutPage).complete_order(table.hashes.first)
end

When(/^I checkout using a Credit card$/) do
  on(CheckoutPage).complete_order('pay_type' => 'Credit card')
end

When(/^I checkout$/) do
  on(CheckoutPage).complete_order
end

When(/^I Complete the adoption of a puppy$/) do
  on(HomePage).adopt
  on(DetailsPage).add_to_cart
  on(ShoppingCartPage).proceed_to_checkout
  on(CheckoutPage).complete_order
end
