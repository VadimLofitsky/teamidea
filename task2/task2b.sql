select product.name, brand.name
    from product join brand on product.brandid = brand.id
    where product.id not in (select distinct goods.productid from goods);