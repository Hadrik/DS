create or alter procedure FinalizeOrder
(
    @p_order_id int out,
    @p_staff_id int,
    @p_customer_id int,
    @p_order_price float,
    @p_order_note nvarchar(500),
    @p_products nvarchar(max) -- JSON
)
as
begin
    begin try
        set nocount on;
        begin transaction;
        
        -- 1
        insert into Objednavka
        (
            zakaznik_osoba_id,
            zamestnanec_osoba_id,
            datum_vytvoreni,
            status,
            poznamka
        )
        values
        (
            @p_customer_id,
            @p_staff_id,
            getdate(),
            'Nedokonceno',
            @p_order_note
        )
        set @p_order_id = @@identity;
        
        -- 2
        declare @jsontable table
        (
            order_id int,
            product_id int,
            quantity int,
            price float,
            note nvarchar(500)
        );
        
        insert into @jsontable
        select *
        from openjson(@p_products)
        with
        (
            order_id int '$.OrderId',
            product_id int '$.ProductId',
            quantity int '$.Quantity',
            price float '$.Price',
            note nvarchar(500) '$.Note'
        );
        
        declare @ProductId int, @Quantity int;
        
        declare TC cursor for
        select product_id, quantity from @jsontable;
        
        open TC;
        
        fetch next from TC into @ProductId, @Quantity;
        
        while @@fetch_status = 0
        begin
            insert into Objednany_Produkt
            (
                objednavka_id,
                produkt_id,
                pocet,
                cena
            )
            values
            (
                @p_order_id,
                @ProductId,
                @Quantity,
                (select cena from Produkt where produkt_id = @ProductId)
            )

            fetch next from TC into @ProductId, @Quantity;
        end
        
        close TC;
        deallocate TC;
        
        -- 3
        if
        (
            select sum(p.cena * p.pocet)
            from Objednany_Produkt p
            where p.objednavka_id = @p_order_id
        ) != @p_order_price
        begin
            rollback transaction;
            set @p_order_id = null;
            return;
        end;
        
        -- 4
        update Objednavka
        set
            celkova_cena = @p_order_price,
            status = 'Objednano'
        where
            objednavka_id = @p_order_id;
        
        commit transaction;
    end try
    begin catch
        rollback transaction;
        set @p_order_id = null;
    end catch
end;