using System.Data;
using System.Data.SqlClient;
using System.Text.Json;
using DBII_Projekt.orm.dto;
using StoreIS.orm;

namespace DBII_Projekt.orm.dao;

public class TransactionDao
{
    /// <summary>
    /// OrderProduct staci kdyz ma vyplnene jen ProductId a Quantity
    /// </summary>
    public static int? FinalizeOrder(Database pDb, int p_staff_id, int p_customer_id, float p_order_price, string p_order_note, OrderProduct[] p_products)
    {
        var db = Database.Connect(pDb);

        try
        {
            // ----------
            
            db.BeginTransaction();

            var o = new Order
            {
                StaffId = p_staff_id,
                CustomerId = p_customer_id,
                Created = DateTime.UtcNow,
                Note = p_order_note
            };
            o.Id = OrderDao.InsertOrder(db, o);

            // ----------
            
            foreach (var op in p_products)
            {
                op.OrderId = o.Id;
                OrderItemDao.InsertOrderItem(db, op);
            }
            
            // ----------

            o.TotalPrice = QueriesDao.GetOrderTotalPrice(db, o.Id);
            if (o.TotalPrice != p_order_price)
            {
                db.Rollback();
                Console.WriteLine("Order price mismatch");
                return null;
            }
            
            // ----------
            
            OrderDao.UpdateOrder(db, o);
            db.EndTransaction();
            
            // ----------
            
            Database.Close(pDb, db);
            return o.Id;
        }
        catch (Exception e)
        {
            db.Rollback();
            Database.Close(pDb, db);
            Console.WriteLine($"Exception: {e.Message}");
            return null;
        }
    }

    public static int? FinalizeOrderSP(Database pDb, int p_staff_id, int p_customer_id, float p_order_price,
        string p_order_note, OrderProduct[] p_products)
    {
        var db = Database.Connect(pDb);
        
        var command = db.CreateCommand("FinalizeOrder");
        command.CommandType = System.Data.CommandType.StoredProcedure;
        
        var orderIdParam = new SqlParameter("@p_order_id", DBNull.Value);
        orderIdParam.Direction = System.Data.ParameterDirection.Output;
        orderIdParam.Size = sizeof(int);
        command.Parameters.Add(orderIdParam);
        
        command.Parameters.AddWithValue("@p_staff_id", p_staff_id);
        command.Parameters.AddWithValue("@p_customer_id", p_customer_id);
        command.Parameters.AddWithValue("@p_order_price", p_order_price);
        command.Parameters.AddWithValue("@p_order_note", p_order_note);
        
        var productsJson = JsonSerializer.Serialize(p_products);
        command.Parameters.Add(new SqlParameter("@p_products", SqlDbType.NVarChar) { Value = productsJson });

        db.ExecuteNonQuery(command);
        
        if (orderIdParam.Value is DBNull)
        {
            Console.WriteLine("Order price mismatch");
            return null;
        }

        var orderId = Convert.ToInt32(orderIdParam.Value);
        
        Database.Close(pDb, db);
        
        return orderId;
    }
}