using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Dynamic;
using Microsoft.AspNetCore.Identity;

namespace backend_api.Models
{
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int UserID { get; set; }
        
        //public string email { get; set; }
        public string firstname { get; set; }
        public string lastname { get; set; }
        
        public string phoneNumber { get; set; }
        
        public List<int> pinnedUserIDs { get; set; }
        
        public string userImage { get; set; }
        
        public string userDescription { get; set; }
        
        public bool isOnline { get; set; }

        public bool isAdmin { get; set; }

        public int employeeLevel { get; set; }
        
        public UserRoles userRoles { get; set; }

        public OfficeLocation officeLocation { get; set; }
        public List<string> userEmails { get; set; }
        
        public override string ToString()
        {
            return UserID.ToString() + " " + firstname + " " + lastname;
        }
    }
}