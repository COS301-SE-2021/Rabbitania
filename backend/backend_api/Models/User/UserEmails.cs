using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using backend_api.Models.User.Requests;

namespace backend_api.Models.User
{
    public class UserEmails
    {
         [Key]
         [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
         public int UserEmailId { get; set; }

         public string UserEmail { get; set; }
         
         [ForeignKey("User")] 
         public int UserId { get; set; }
         public User User { get; set; }

         public UserEmails(string email, int userId)
         {
             UserEmail = email;
             UserId = userId;
         }
    }
}