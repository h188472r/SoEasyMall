package com.soeasy.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
	
	
	@Entity
	@Table(name = "ProductCategory")
	public class ProductCategoryBean implements Serializable {
		private static final long serialVersionUID = 1L;

		@Id
		@GeneratedValue(strategy = GenerationType.IDENTITY)
		private Integer productCategoryId;
		
		@ManyToOne(fetch=FetchType.LAZY)
		@JoinColumn(name="parent_id")
		private ProductCategoryBean category;

		private String productCategoryName;
		
		private Boolean status;
		
		@OneToMany(fetch=FetchType.LAZY,mappedBy="category")
		private List<ProductCategoryBean> categories = new ArrayList<ProductCategoryBean>(0);
		
		
		

		public ProductCategoryBean() {
			super();
			// TODO Auto-generated constructor stub
		}
		

		public ProductCategoryBean(Integer productCategoryId) {
			super();
			this.productCategoryId = productCategoryId;
		}



		public ProductCategoryBean(Integer productCategoryId, Boolean status) {
			super();
			this.productCategoryId = productCategoryId;
			this.status = status;
		}


		public ProductCategoryBean(Integer productCategoryId, ProductCategoryBean category, String productCategoryName,
				Boolean status, List<ProductCategoryBean> categories) {
			super();
			this.productCategoryId = productCategoryId;
			this.category = category;
			this.productCategoryName = productCategoryName;
			this.status = status;
			this.categories = categories;
		}

		public Integer getProductCategoryId() {
			return productCategoryId;
		}

		public void setProductCategoryId(Integer productCategoryId) {
			this.productCategoryId = productCategoryId;
		}

		
		
		public ProductCategoryBean getCategory() {
			return category;
		}

		public void setCategory(ProductCategoryBean category) {
			this.category = category;
		}

		public String getProductCategoryName() {
			return productCategoryName;
		}

		public void setProductCategoryName(String productCategoryName) {
			this.productCategoryName = productCategoryName;
		}

		public Boolean getStatus() {
			return status;
		}

		public void setStatus(Boolean status) {
			this.status = status;
		}

		
		public List<ProductCategoryBean> getCategories() {
			return categories;
		}

		public void setCategories(List<ProductCategoryBean> categories) {
			this.categories = categories;
		}

		public static long getSerialversionuid() {
			return serialVersionUID;
		}

		
		
		
	}

		