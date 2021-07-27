package com.soeasy.service.mallService.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import com.soeasy.model.Order.OrderBean;
import com.soeasy.model.Order.PaymentModel;
import com.soeasy.model.Order.PaypalConfig;
import com.soeasy.model.Order.PaypalPaymentIntent;
import com.soeasy.model.Order.PaypalPaymentMethod;
import com.soeasy.service.mallService.PaymentService;


@Service
public class PaymentServiceImpl implements PaymentService {

    @Autowired
    private PaypalConfig config;
  

    @Autowired
    public PaymentServiceImpl(APIContext apiContext) {
        this.apiContext = apiContext;
    }
    
    @Autowired
    private final APIContext apiContext;
    
    private final String TWD = "TWD";
    

    @Override
    public Payment createPayment(PaymentModel paymentModel , String cancelUrl, String successUrl) throws PayPalRESTException {
        Amount amount = new Amount();
    	//默認為TWD
        if(null!=paymentModel.getCurrency()){
            amount.setCurrency(paymentModel.getCurrency());
        }else{
            amount.setCurrency(TWD);
        }
        amount.setTotal(paymentModel.getAmount());
        List<Transaction> transactions = new ArrayList<>();
        Transaction transaction = new Transaction();
        transaction.setDescription(paymentModel.getDescription());
        transaction.setAmount(amount);
        transactions.add(transaction);

        //付錢
        
        Payer payer = new Payer();
        payer.setPaymentMethod(PaypalPaymentMethod.paypal.toString());
        Payment payment = new Payment();
        payment.setIntent(PaypalPaymentIntent.sale.toString());
        payment.setPayer(payer);
        payment.setTransactions(transactions);
        /**
         * 回傳地址
         */
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl(cancelUrl);
        redirectUrls.setReturnUrl(successUrl);
        payment.setRedirectUrls(redirectUrls);
        return payment.create(apiContext);
    }

    @Override
    public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
        Payment payment = new Payment();
        payment.setId(paymentId);
        PaymentExecution paymentExecute = new PaymentExecution();
        paymentExecute.setPayerId(payerId);
        return payment.execute(apiContext, paymentExecute);
    }
    
   private List<Transaction>gettransactionInformation(OrderBean order){
	   Details details = new Details();
	   details.setShipping(order.getShipping());
	   return null;
   }




	


}

