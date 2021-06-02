using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models
{
    public class UserEmails
    {
         [Key]
         [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
         public int userEmailsID { get; set; }

         public string[] userEmails { get; set; }
    }
}