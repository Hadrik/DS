using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBII_Projekt.orm.dto;

[Table("Produkt")]
public class Product
{
    [Key]
    [Column("produkt_id")]
    public int Id { get; set; }
    
    [Column("nazev")]
    public string Name { get; set; }
    
    [Column("popis")]
    public string? Description { get; set; }
    
    [Column("cena")]
    public float Price { get; set; }
    
    [Column("archivovany")]
    public bool? Archived { get; set; }
}