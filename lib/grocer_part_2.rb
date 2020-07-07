require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  new_cart = []
  cart.each do |cart_item|
    coupons.each do |item|
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
    #new_cart.map do |new_cart_item|
    #  if new_cart_item[:count] == 0
    #  new_cart.delete(new_cart_item)
    #  end
    #end  
    if coupons == []
      cart
    else
      new_cart
    end 
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
  new_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons).uniq)
  final_total = 0 
  new_cart.map do |item|
    final_total += (item[:price]*item[:count]).round(2)
  end  
  if final_total > 100
    final_total-(final_total*0.1)
  else
    final_total
  end
end
