-- список брендов с указанием количества единиц продукта на каждом складе
-- и количества на каждом складе для текущего бренда
select b.name brand,
       w.name whouse,
       sum(g.quantity) qty
    from brand b,
         warehouse w
    left join goods g
        on g.warehouseid=w.id
    left join product p
        on g.productid = p.id
    where p.brandid=b.id
    group by w.name, b.name
    order by b.name asc, qty desc;
