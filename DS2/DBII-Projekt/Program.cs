using DBII_Projekt.orm.dao;
using DBII_Projekt.orm.dto;
using StoreIS.orm;

namespace DBII_Projekt;

class Program
{
    static void Main(string[] args)
    {
        var db = new Database();
        db.Connect();
        
        // Fail - spatna celkova cena
        var result = TransactionDao.FinalizeOrder(db, 2, 1, 100.0f, "Test order 1", [
            new OrderProduct { ProductId = 1, Quantity = 2 },
            new OrderProduct { ProductId = 2, Quantity = 1 }
        ]);
        Console.WriteLine($"1 - {(result is null ? "Fail" : "Success - ID: " + result)}");
        
        result = TransactionDao.FinalizeOrderSP(db, 2, 1, 100.0f, "Test order SP 1", [
            new OrderProduct { ProductId = 1, Quantity = 2 },
            new OrderProduct { ProductId = 2, Quantity = 1 }
        ]);
        Console.WriteLine($"1 SP - {(result is null ? "Fail" : "Success - ID: " + result)}");
        
        // Success
        result = TransactionDao.FinalizeOrder(db, 2, 1, 400.0f, "Test order 2", [
            new OrderProduct { ProductId = 1, Quantity = 2 },
            new OrderProduct { ProductId = 2, Quantity = 1 }
        ]);
        Console.WriteLine($"2 - {(result is null ? "Fail" : "Success - ID: " + result)}");
        
        result = TransactionDao.FinalizeOrderSP(db, 2, 1, 400.0f, "Test order SP 2", [
            new OrderProduct { ProductId = 1, Quantity = 2 },
            new OrderProduct { ProductId = 2, Quantity = 1 }
        ]);
        Console.WriteLine($"2 SP - {(result is null ? "Fail" : "Success - ID: " + result)}");
        
        db.Close();
    }
}