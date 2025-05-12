using System.Data.SqlClient;
using DBII_Projekt.orm.dto;
using StoreIS.orm;

namespace DBII_Projekt.orm.dao;

public class OrderItemDao
{
    private static string sqlInsert =
        """
        insert into Objednany_Produkt(objednavka_id, produkt_id, pocet, cena)
        values(@OrderId, @ProductId, @Quantity, @Price)
        """;

    public static void InsertOrderItem(Database pDb, OrderProduct orderProduct)
    {
        var db = Database.Connect(pDb);

        var command = db.CreateCommand(sqlInsert);
        orderProduct.Price = QueriesDao.GetProductPrice(db, orderProduct.ProductId);
        PrepareCommand(command, orderProduct);
        db.ExecuteNonQuery(command);
    }

    private static void PrepareCommand(SqlCommand command, OrderProduct orderProduct)
    {
        command.Parameters.AddWithValue("@OrderId", orderProduct.OrderId);
        command.Parameters.AddWithValue("@ProductId", orderProduct.ProductId);
        command.Parameters.AddWithValue("@Quantity", orderProduct.Quantity);
        command.Parameters.AddWithValue("@Price", orderProduct.Price);
    }
}