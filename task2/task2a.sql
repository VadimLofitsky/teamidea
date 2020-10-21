select w.name whouse, sum(g.quantity) qty
    from goods g
         join warehouse w
              on g.warehouseid = w.id
         join product p
              on g.productid = p.id
    where p.brandid in (select id from brand where country='DE')
    group by w.name;