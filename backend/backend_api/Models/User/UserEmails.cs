using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.User
{
    public class UserEmails
    {
         [Key]
         [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
         public int userEmailID { get; set; }

         public string userEmail { get; set; }
         
         [ForeignKey("User")] 
         public int UserID { get; set; }
         public User User { get; set; }
    }
}