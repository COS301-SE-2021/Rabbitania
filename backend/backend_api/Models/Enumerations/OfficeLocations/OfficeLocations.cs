using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.Enumerations.OfficeLocations
{
    public class OfficeLocations : IOfficeLocations
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public OfficeLocation OfficeLocation { get; set; }
        
        public string Name { get; set; }
    }
}