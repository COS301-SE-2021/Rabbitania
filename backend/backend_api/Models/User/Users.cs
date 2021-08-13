using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

namespace backend_api.Models.User
{
    public class Users : IdentityUser<int>
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

        public Users(int userId, string name, string phoneNumber, string userImgUrl, string userDescription, int employeeLevel, OfficeLocation officeLocation, UserRoles userRole)
        {
            UserId = userId;
            Name = name;
            PhoneNumber = phoneNumber;
            UserImgUrl = userImgUrl;
            UserDescription = userDescription;
            EmployeeLevel = employeeLevel;
            OfficeLocation = officeLocation;
            EmployeeLevel = employeeLevel;
        }

        public Users()
        {
        }

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int UserId { get; set; }
        
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