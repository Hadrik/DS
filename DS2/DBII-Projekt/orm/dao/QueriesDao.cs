using DBII_Projekt.orm.dto;
using StoreIS.orm;

namespace DBII_Projekt.orm.dao;

public static class QueriesDao
{
    private static string sqlProductPrice =
        """
        select Produkt.cena
        from Produkt
        where Produkt.produkt_id = @ProductId
        """;

    private static string sqlTotalPrice =
        """
        select sum(o.cena * o.pocet)
        from Objednany_Produkt o
        where o.objednavka_id = @OrderId
        """;

    public static float GetProductPrice(Database pDb, int productId)
    {
        var db = Database.Connect(pDb);
        
        var command = db.CreateCommand(sqlProductPrice);
        command.Parameters.AddWithValue("@ProductId", productId);
        var priceReader = db.Select(command);
        if (!priceReader.Read())
        {
            priceReader.Close();
            return 0.0f;
        }
        
        var price = (float)priceReader.GetDouble(0);
        priceReader.Close();
        
        return price;
    }

    public static float GetOrderTotalPrice(Database pDb, int orderId)
    {
        var db = Database.Connect(pDb);
        
        var command = db.CreateCommand(sqlTotalPrice);
        command.Parameters.AddWithValue("@OrderId", orderId);
        var priceReader = db.Select(command);
        if (!priceReader.Read())
        {
            priceReader.Close();
            return 0.0f;
        }
        
        var price = (float)priceReader.GetDouble(0);
        priceReader.Close();
        
        return price;
    }
}