using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBII_Projekt.orm.dto;

[Table("Objednavka")]
public class Order
{
    [Key]
    [Column("objednavka_id")]
    public int Id { get; set; }
    
    // [ForeignKey("Zakaznik")]
    [Column("zakaznik_osoba_id")]
    public int? CustomerId { get; set; }
    
    // [ForeignKey("Zamestnanec")]
    [Column("zamestnanec_osoba_id")]
    public int? StaffId { get; set; }
    
    [Column("datum_vytvoreni")]
    public DateTime? Created { get; set; }
    
    [Column("status")]
    public string? Status { get; set; }
    
    [Column("celkova_cena")]
    public float? TotalPrice { get; set; }
    
    [Column("poznamka")]
    public string? Note { get; set; }
}