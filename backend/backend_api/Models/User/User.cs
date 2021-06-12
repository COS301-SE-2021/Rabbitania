using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.User
{
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int UserID { get; set; }
        
        //public string email { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        
        public int phoneNumber { get; set; }
        
        public List<int> pinnedUserIDs { get; set; }
        
        public string userImage { get; set; }
        
        public string userDescription { get; set; }
        
        public bool isOnline { get; set; }

        public bool isAdmin { get; set; }

        public int employeeLevel { get; set; }
        
        public int userRole { get; set; }//corresponds to UserRoles enum

        public int officeLocationID { get; set; }

        public override string ToString()
        {
            return UserID.ToString() + " " + firstname + " " + lastname;
        }
    }
}