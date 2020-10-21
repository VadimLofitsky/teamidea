-- список брендов с указанием количества единиц продукта текущего бренда на каждом складе
-- с учётом возможности отсутствия товаров некоторых брендов на некоторых складах
with all_pairs as (     -- все возможные пары бренд-склад
    select b.name brand,
           w.name whouse,
           b.id brandid,
           w.id whid
        from brand b, warehouse w
    ),
    each_brand_per_wh as (      -- количество товара каждого имеющегося бренда на каждом складе
        select ap.brand brand,
               ap.whouse whouse,
               sum(g.quantity) qty
            from all_pairs ap
            join goods g
                on g.warehouseid = ap.whid
            join product p
                on g.productid = p.id
            where p.brandid = ap.brandid
            group by ap.whouse, ap.brand
    )
select ap.brand, ap.whouse, ebpw.qty
    from all_pairs ap
    left outer join each_brand_per_wh ebpw      -- учёт возможности отсутствия бренда на складе
        on ap.brand=ebpw.brand and
           ap.whouse=ebpw.whouse
    order by ap.brand, ebpw.qty desc;
