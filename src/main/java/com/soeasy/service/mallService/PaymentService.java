package com.soeasy.service.mallService;

import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import com.soeasy.model.Order.PaymentModel;


public interface PaymentService {

   
    Payment createPayment(PaymentModel paymentModel, String cancelUrl, String successUrl) throws PayPalRESTException;

    Payment executePayment(String paymentId, String payerId) throws PayPalRESTException;


}
