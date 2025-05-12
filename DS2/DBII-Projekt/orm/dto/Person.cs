using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DBII_Projekt.orm.dto;

[Table("Osoba")]
public class Person
{
    [Key]
    [Column("osoba_id")]
    public int Id { get; set; }
    
    [Column("jmeno")]
    public string Name { get; set; }
    
    [Column("adresa")]
    public string Address { get; set; }
    
    [Column("email")]
    public string Email { get; set; }
}