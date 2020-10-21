select product.name product, brand.name brand
    from product join brand on product.brandid = brand.id
    where product.id not in (select distinct goods.productid from goods);