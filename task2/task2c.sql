with prodmax as (       -- максимальное количество каждого из продуктов
    select distinct productid productid, max(quantity) product_max
        from goods
        group by productid
    ),
    prodmax_which_whouse as (       -- список id продуктов с указанием их максимального количетсва и склада с таким количеством
    select prodmax.productid, prodmax.product_max max, w.name whouse
        from prodmax
        join goods g on g.productid=prodmax.productid and g.quantity=prodmax.product_max
        join warehouse w on g.warehouseid=w.id
    ),
    having_gt_100 as (      -- имена продуктов, суммарное количество которых >100
    select g.productid productid, p.name product, sum(g.quantity) product_sum
        from goods g
        join product p on g.productid = p.id
        group by g.productid, p.name
        having sum(g.quantity) > 100
    )
select hg100.product product,       -- продукт (product.name)
        hg100.product_sum sum,      -- суммарное количество по всем складам
        pww.whouse whouse,          -- склад (warehouse.name)
        pww.max max_on_wh           -- количество на складе
    from prodmax_which_whouse pww
    join having_gt_100 hg100 on pww.productid=hg100.productid;