using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_api.Models.User
{
    public class Users
    {
        public Users(int userId, string name, string phoneNumber, List<int> pinnedUserIds, string userImgUrl, string userDescription, bool isAdmin, int employeeLevel, UserRoles userRole, OfficeLocation officeLocation)
        {
            UserId = userId;
            this.Name = name;
            this.PhoneNumber = phoneNumber;
            this.PinnedUserIds = pinnedUserIds;
            this.UserImgUrl = userImgUrl;
            this.UserDescription = userDescription;
            this.IsAdmin = isAdmin;
            this.EmployeeLevel = employeeLevel;
            this.UserRole = userRole;
            this.OfficeLocation = officeLocation;
        }

        public Users()
        {
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int UserId { get; set; }
        
        //public string email { get; set; }
        public string Name { get; set; }

        public string PhoneNumber { get; set; }
        
        public List<int> PinnedUserIds { get; set; }
        
        public string UserImgUrl { get; set; }
        
        public string UserDescription { get; set; }

        public bool IsAdmin { get; set; }

        public int EmployeeLevel { get; set; }
        
        public UserRoles UserRole { get; set; }//corresponds to UserRoles enum

        public OfficeLocation OfficeLocation { get; set; }

        public override string ToString()
        {
            return UserId.ToString() + " " + Name;
        }
    }
}