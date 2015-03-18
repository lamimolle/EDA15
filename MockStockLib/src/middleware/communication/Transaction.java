/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package middleware.communication;

/**
 *
 * @author Santos
 */

import java.io.Serializable;
import middleware.common.StockProduct;

public class Transaction implements Serializable {
    
    private String transactionType;
    private StockProduct stockProduct;
    private String author;
    private int qty;

    public Transaction(String author, StockProduct stockProduct, String transactionType, int qty){
        this.stockProduct = stockProduct;
        this.author = author;
        this.transactionType = transactionType.toLowerCase();
        this.qty = qty;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public StockProduct getStockProduct() {
        return stockProduct;
    }

    public String getAuthor() {
        return author;
    }
    
    public int getQty() {
        return qty;
    }
}
