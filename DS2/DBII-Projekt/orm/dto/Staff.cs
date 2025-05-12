using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBII_Projekt.orm.dto;

[Table("Zamestnanec")]
public class Staff
{
    [Key]
    [Column("osoba_id")]
    public int Id { get; set; }
    
    [Column("cislo_uctu")]
    public string? BankAccountNumber { get; set; }
    
    [Column("pozice")]
    public string? Position { get; set; }
}