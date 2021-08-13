using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.Enumerations
{
    public abstract class UserRolesModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public UserRoles UserRole { get; set; }
        
        public string Type { get; set; }
    }
}