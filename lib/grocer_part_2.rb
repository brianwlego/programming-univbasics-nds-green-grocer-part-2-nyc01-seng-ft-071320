require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupon_names = coupons.each_with_object([]) {|names, a| a << names[:item]}
  #binding.pry
  new_cart = []
  cart.each do |cart_item|
    coupons.each do |item|
      #binding.pry
      if item[:item] == cart_item[:item] && cart_item[:count] >= item[:num]
      item[:clearance] = cart_item[:clearance]
      item[:item] = "#{item[:item]} W/COUPON"
      item[:count] = ((cart_item[:count]/item[:num]).to_int) * item[:num]
      cart_item[:count] = cart_item[:count]%item[:num]
      item.delete(:num)
      item[:price] = item[:cost]/item[:count]
      item.delete(:cost)
      new_cart.push(item)
      new_cart.push(cart_item)
    else
      new_cart.push(cart_item)
      end
    end
  end
  new_cart.map do |new_cart_item|
    if new_cart_item[:count] == 0
      new_cart.delete(new_cart_item)
      binding.pry
    end  
  if coupons == []
    cart
  else
    new_cart
  end 
  #binding.pry
end

def apply_clearance(cart)
  new_cart = []
  cart.each do |item|
    if item[:clearance] == false 
      new_cart.push(item)
    elsif item[:clearance] == true 
      item[:price] = (item[:price]-(item[:price]*0.2)).round(2)
      new_cart.push(item)
    end
  end  
  new_cart
end



def checkout(cart, coupons)
  #binding.pry
  new_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  binding.pry
  final_total = 0 
  new_cart.map do |item|
    
    final_total += item[:price]*item[:count]
    #binding.pry
  end  
  final_total
  #binding.pry
end
