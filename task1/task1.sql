-- список брендов с указанием количества единиц продукта текущего бренда на каждом складе
-- с учётом возможности отсутствия товаров некоторых брендов на некоторых складах
with all_pairs as (             -- все возможные пары бренд-склад
        select b.name brand, w.name whouse
            from brand b, warehouse w
    ),
    each_brand_per_wh as (      -- количество товара каждого имеющегося бренда на каждом складе
        select b.name brand,
                w.name whouse,
                sum(g.quantity) qty
            from brand b, warehouse w
            left outer join goods g
                on g.warehouseid = w.id
            left outer join product p
                on g.productid = p.id
            where p.brandid = b.id
            group by w.name, b.name
    )
select ap.brand, ap.whouse, ebpw.qty
    from all_pairs ap
    left outer join each_brand_per_wh ebpw      -- учёт возможности отсутствия бренда на складе
        on ap.brand=ebpw.brand and
           ap.whouse=ebpw.whouse
    order by ap.brand, ebpw.qty desc;
