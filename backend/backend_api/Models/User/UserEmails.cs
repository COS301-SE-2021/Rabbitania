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

         public string UsersEmail { get; set; }
        
         public UserEmails(string email, int userId)
         {
             UsersEmail = email;
             UserId = userId;
         }
         
         public int UserId { get; set; }
         public Users User { get; set; }

        
         public UserEmails()
         {
             
         }
    }
}