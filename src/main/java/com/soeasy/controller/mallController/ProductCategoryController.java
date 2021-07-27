package com.soeasy.controller.mallController;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.soeasy.model.ProductCategoryBean;
import com.soeasy.service.mallService.ProductCategoryService;

@Controller
@RequestMapping("/mall/category")
public class ProductCategoryController {
	
	@Autowired
	private ProductCategoryService productCategoryService;
	
	
	@GetMapping("")
	public String index(Model model) {
		model.addAttribute("categories",productCategoryService.findParentCategories());
		return "/mall/category/productCategory";
	}
	
	
//	========================================================================================

	
	@GetMapping("/add")
	public String add(Model model) {
		ProductCategoryBean category=new ProductCategoryBean();
		category.setStatus(true);
		model.addAttribute("category",category);
		return "/mall/category/addProductCategory";
	}
	
	@PostMapping("/add")
	public String addCategory(@ModelAttribute("category")ProductCategoryBean category) {
		
		//category.setCategories(null);
		//category.setCategory(new ProductCategoryBean(-1));
		productCategoryService.save(category);
		return "redirect:/mall/category";
	}
	
//	========================================================================================

	@GetMapping("/delete/{productCategoryId}")
	public String deleteCategory(@PathVariable("productCategoryId")int productCategoryId ,RedirectAttributes redirectAttributes) {
		try{
			productCategoryService.delete(productCategoryId);
		}catch(Exception e) {
		redirectAttributes.addAttribute("error","Deleted Failed");
		}
		return "redirect:/mall/category";
	}
	
//	========================================================================================
	
	//修改跳轉出現資料
	
	@GetMapping("/update/{productCategoryId}")
	public String editCategory(@PathVariable("productCategoryId")int productCategoryId,Model model) {
		model.addAttribute("category",productCategoryService.findByProductCategoryId(productCategoryId));
		return "/mall/category/updateProductCategory";
	}
	
	//更動可以保存
	
	@PostMapping("/update/{productCategoryId}")
	public String editCategory(
			@ModelAttribute("category") ProductCategoryBean category,
			BindingResult result, 
			Model model,
			@PathVariable int productCategoryId, 
			HttpServletRequest request) {
		productCategoryService.save(category);
		return "redirect:/mall/category";
	}
	
//	========================================================================================

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	===================================================================
	
//	// 默認是10條 這裡改成5 
//	// 使用印出分頁內容的方式去取值
//	@GetMapping("/category")
//	public String Category(@PageableDefault(size=10,sort= {"productCategoryId"},direction=Sort.Direction.DESC)
//	Pageable pageable,Model model) {
//		
//		List<ProductCategoryBean> list=productCategoryService.listCategory(pageable).getContent();
//		model.addAttribute("page",list);		
//		System.out.println(productCategoryService.listCategory(pageable));
//		return"mall/ProductCategory";
//	}
//	
//	//新增產品 使用Post請求
//	//跳轉add提交頁  於新增時，送出空白的表單讓使用者輸入資料
//
//		@GetMapping("/addCategory")
//		public String addcategory(Model model) {
//			//ProductCategoryBean product = new ProductCategoryBean();
////			product.setProductCategoryName("海鮮套餐");
////			model.addAttribute("product", product);
//
//			return "mall/addProductCategory";
//		}
//	
//	
//	@PostMapping("/addcategory")
//	public String addProduct(
//			@ModelAttribute("category") /* @Valid */ ProductCategoryBean category, 
//			BindingResult result, Model model)
//			//,HttpServletRequest request)
//			{
//		productCategoryService.saveCategory(category);
//	// 跳轉至查詢所有頁面
//	return "redirect:/mall/category";
//	}
//	
//
//	
//	// 刪除一筆紀錄
//		//送不出DELETE 先用POST
//			@PostMapping("/deletecategory/{productCategoryId}")
//			public String delete(@PathVariable("productCategoryId") Integer productCategoryId) {
//		        productCategoryService.deleteCategory(productCategoryId);
//	        	System.out.println("刪除一條分類");
//				return "redirect:/mall/category"; 
//			}
			
	
	
	
	
	
	}
	
	
