using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.User
{
    public class User
    {
        public User(int userId, string firstname, string lastname, int phoneNumber, List<int> pinnedUserIDs, string userImage, string userDescription, bool isOnline, bool isAdmin, int employeeLevel, UserRoles userRole, OfficeLocation officeLocation)
        {
            UserID = userId;
            this.firstname = firstname;
            this.lastname = lastname;
            this.phoneNumber = phoneNumber;
            this.pinnedUserIDs = pinnedUserIDs;
            this.userImage = userImage;
            this.userDescription = userDescription;
            this.isOnline = isOnline;
            this.isAdmin = isAdmin;
            this.employeeLevel = employeeLevel;
            this.userRole = userRole;
            this.officeLocation = officeLocation;
        }

        public User()
        {
        }

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
        
        public UserRoles userRole { get; set; }//corresponds to UserRoles enum

        public OfficeLocation officeLocation { get; set; }

        public override string ToString()
        {
            return UserID.ToString() + " " + firstname + " " + lastname;
        }
    }
}