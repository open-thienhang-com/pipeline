CREATE OR REPLACE FUNCTION discount_order(customer_name_buy VARCHAR(100),list_product_id INT[],store VARCHAR(100),employee VARCHAR(100), payment_order VARCHAR(50), delivery_order VARCHAR(50), campaign_id_order INT,strategy_id_order INT, discount_type_id INT, discount_order_value_id INT  ) RETURNS INT AS
$$
DECLARE
    customer_record customer;
    store_record store;
    employee_record employee;
    payment_record payment;
    delivery_record delivery;
    discount_value_record discount_value;
    campaign_record campaign;
    strategy_record strategy;
    total_cost DECIMAL(12,2);
    number_product INT;
    product_discount product;
	order_id INT;
BEGIN
    --Xác định thông tin khách hàng, khoá lại cho đến khi xong
    SELECT * INTO customer_record FROM customer WHERE customer_name = customer_name_buy LIMIT 1 FOR UPDATE;
      --Xác định thông tin nhân viên 
    SELECT * INTO employee_record FROM employee WHERE employee_name = employee;
      --Xác định thông tin cửa hàng
    SELECT * INTO store_record FROM store WHERE name_store = store;
    -- Xác định phương thức thanh toán 
    SELECT * INTO payment_record FROM payment WHERE payment_method = payment_order;
    -- Xác định phương thức vận chuyển
    SELECT * INTO delivery_record FROM delivery WHERE delivery_method = delivery_order;
    -- Xác định giá trị giảm giá
    SELECT * INTO discount_value_record FROM discount_value WHERE discount_value_id = discount_order_value_id;
     -- Xác định chiến dịch 
    SELECT * INTO campaign_record FROM campaign WHERE campaign_id = campaign_id_order;
     -- Xác định chiến lược
    SELECT * INTO strategy_record FROM strategy WHERE strategy_id = strategy_id_order;
    -- Tính tiền tất cả sản phẩm trong danh sách sản phẩm mua 
    SELECT SUM(price) INTO total_cost
    FROM product
    WHERE product_id = ANY(list_product_id);
    
    --Kiểm tra xem khuyến mãi có đang chạy không
    IF campaign_record.status = 'In progress' AND strategy_record.status = 'In progress' THEN
        CASE discount_type_id
        WHEN 1 THEN 
            SELECT COUNT(product_id) INTO number_product FROM product WHERE product_id = discount_value_record.value_discount;
            SELECT * INTO product_discount FROM product WHERE product_id = discount_value_record.value_discount;
            IF number_product > 1 THEN
                total_cost=total_cost - (number_product/2)*product_discount.price;
            END IF;
        WHEN 2 THEN 
            total_cost=total_cost - total_cost*discount_value_record.value_discount;
        WHEN 3 THEN 
            total_cost=total_cost - total_cost*discount_value_record.value_discount;
        WHEN 4 THEN 
            total_cost=total_cost - total_cost*discount_value_record.value_discount;
        WHEN 5 THEN 
            total_cost=total_cost - total_cost*discount_value_record.value_discount;
        WHEN 6 THEN 
            SELECT COUNT(product_id) INTO number_product FROM product WHERE product_category = discount_value_record.value_discount;
            IF number_product > 3 THEN
                total_cost=total_cost - total_cost*0.1;
            END IF;
        WHEN 7 THEN 
            total_cost=total_cost - discount_value_record.value_discount;
        WHEN 8 THEN 
            total_cost=total_cost - discount_value_record.value_discount;
        WHEN 9 THEN 
            total_cost=total_cost - discount_value_record.value_discount;
        WHEN 10 THEN 
            total_cost=total_cost - discount_value_record.value_discount;
        END;
    ELSE
        RAISE NOTICE 'Promotion has expired';
    END IF;

    
    --Thêm vào bảng order
   INSERT INTO Orders (
    customer_id, 
   product_id, 
   store_id,
   employee_id,
   payment_id,
   delivery_id,
   date_order_id,
   discount_id,
   campaign_id,
   strategy_id, 
   discount_type_id,
   discount_value_id,
   total_amount_order,
   discount_amount
   ) VALUES
	(customer_record.customer_id, unnest(list_product_id), store_record.store_id, employee_record.employee_id, payment_record.payment_id, 
    delivery_record.delivery_id, 1, 1, campaign_id, strategy_id, discount_type_id, discount_value_record.discount_value_id, total_cost, discount_value_record.value) returning orderid INTO order_id;

    -- Cập nhật lại số lượng sản phẩm
    UPDATE product
    SET stock = stock -1
    WHERE product_id = ANY(list_product_id);

    RETURN order_id;

EXCEPTION
    WHEN OTHERS THEN    
        --Rollback the transaction on any exception
        RAISE NOTICE 'An error occurred. Rolling back transaction.';
        ROLLBACK;
        RAISE;
END;
$$
LANGUAGE plpgsql;
-- SELECT discount_order('TranHoangM', ARRAY [1,2,3] , 'HihiStore7Amazon', 'LeThiN', 'Cash', 'Home delivery', 1, 1, 1, 1);
-- (1, unnest(ARRAY[1,2,3]), 1, 1, 1, 1, 1, 1,1,1,1,1,15,10)