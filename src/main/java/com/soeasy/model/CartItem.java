package com.soeasy.model;


public class CartItem  {

	private ProductBean product;
	private int cartQuantity;
	
	public ProductBean getProduct() {
		return product;
	}
	public void setProduct(ProductBean product) {
		this.product = product;
	}
	public int getCartQuantity() {
		return cartQuantity;
	}
	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}
	
	public CartItem(ProductBean product, int cartQuantity) {
		super();
		this.product = product;
		this.cartQuantity = cartQuantity;
	}
	public CartItem() {
		super();
		// TODO Auto-generated constructor stub
	}

	

	
	
	

}
