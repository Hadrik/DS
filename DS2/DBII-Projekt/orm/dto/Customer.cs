using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBII_Projekt.orm.dto;

[Table("Zakaznik")]
public class Customer
{
    [Key]
    [Column("osoba_id")]
    public int Id { get; set; }
    
    [Column("heslo")]
    public string Password { get; set; }
    
    [Column("fakturacni_adresa")]
    public string? FAddress { get; set; }
    
    [Column("cislo_karty")]
    public string? CardNumber { get; set; }
}