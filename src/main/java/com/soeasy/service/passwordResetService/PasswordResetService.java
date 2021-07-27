package com.soeasy.service.passwordResetService;

import java.util.List;

import org.springframework.mail.SimpleMailMessage;

import com.soeasy.model.CustomerBean;
import com.soeasy.model.PasswordResetValidate;
import com.soeasy.model.ShopBean;

public interface PasswordResetService {
	//使用@Async進行非同步發送郵件
	void sendPasswordResetEmail(SimpleMailMessage email);
	//新增顧客會員密碼重製申請記錄
    void insertCustomerResetRecord(PasswordResetValidate passwordResetValidate, CustomerBean customerBean, String resetToken);
    //新增廠商會員密碼重製申請記錄
    void insertShopResetRecord(PasswordResetValidate passwordResetValidate, ShopBean shopBean, String resetToken);
    //以Token查詢重製申請記錄
    List<PasswordResetValidate> findUserByResetToken(String resetToken);
    //驗證是否發送重製郵件，一天requestPerDay次，與上一次請求時間間隔interval分鐘
    Boolean sendValidateLimitation(String email, String memberType, Long requestPerDay, Long interval);
    //驗證連結是否失效，1.超時 2.舊連結被新的覆蓋
    Boolean validateLimitation(String email, Long requestPerDay, Long interval, String token);
}
