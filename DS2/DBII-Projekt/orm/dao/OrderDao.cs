using System.Data.SqlClient;
using DBII_Projekt.orm.dto;
using StoreIS.orm;

namespace DBII_Projekt.orm.dao;

public static class OrderDao
{
    private static string sqlInsert =
        """
        insert into Objednavka(zakaznik_osoba_id, zamestnanec_osoba_id, datum_vytvoreni, status, poznamka)
        output inserted.objednavka_id
        values(@CustomerId, @StaffId, @Created, @Status, @Note)
        """;

    private static string sqlUpdate =
        """
        update Objednavka
        set celkova_cena = @TotalPrice, status = @Status
        where objednavka_id = @OrderId
        """;
    
    public static int InsertOrder(Database pDb, Order order)
    {
        var db = Database.Connect(pDb);
        
        var command = db.CreateCommand(sqlInsert);
        PrepareInsertCommand(command, order);
        var orderId = db.ExecuteScalar(command);
        
        return (int)orderId;
    }
    
    private static void PrepareInsertCommand(SqlCommand command, Order order)
    {
        command.Parameters.AddWithValue("@CustomerId", order.CustomerId);
        command.Parameters.AddWithValue("@StaffId", order.StaffId);
        command.Parameters.AddWithValue("@Created", DateTime.UtcNow);
        command.Parameters.AddWithValue("@Status", "Nedokonceno");
        command.Parameters.AddWithValue("@Note", order.Note);
    }
    
    public static void UpdateOrder(Database pDb, Order order)
    {
        var db = Database.Connect(pDb);
        
        var command = db.CreateCommand(sqlUpdate);
        PrepareUpdateCommand(command, order);
        db.ExecuteNonQuery(command);
    }
    
    private static void PrepareUpdateCommand(SqlCommand command, Order order)
    {
        command.Parameters.AddWithValue("@TotalPrice", order.TotalPrice);
        command.Parameters.AddWithValue("@Status", "Objednano");
        command.Parameters.AddWithValue("@OrderId", order.Id);
    }
}