using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBII_Projekt.orm.dto;

[Table("Objednany_produkt")]
public class OrderProduct
{
    [Key]
    [Column("objednavka_id")]
    public int OrderId { get; set; }
    
    [Key]
    [Column("produkt_id")]
    public int ProductId { get; set; }
    
    [Column("pocet")]
    public int Quantity { get; set; }
    
    [Column("cena")]
    public float Price { get; set; }
    
    [Column("poznamka")]
    public string? Note { get; set; }
}