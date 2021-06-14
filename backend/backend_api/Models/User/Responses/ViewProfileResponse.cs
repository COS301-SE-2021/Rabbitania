using System;

namespace backend_api.Models.User.Responses
{
    public class ViewProfileResponse
    {
        public ViewProfileResponse(string message, string firstName, string lastname, string userImage, string description, int phoneNumber, int empLevel, UserRoles userRole, OfficeLocation officeLocation)
        {
            this.message = message;
            this.firstName = firstName;
            this.lastname = lastname;
            this.userImage = userImage;
            this.description = description;
            this.phoneNumber = phoneNumber;
            this.empLevel = empLevel;
            this.officeLocation = officeLocation;
            this.userRoles = userRole;
        }

        public string message { get; set; }
        public string firstName { get; set; }
        public string lastname { get; set; }
        public string userImage { get; set; }
        public string description { get; set; }
        public int phoneNumber { get; set; }
        public int empLevel { get; set; }
        public OfficeLocation officeLocation { get; set; }
        public UserRoles userRoles { get; set; }

        public ViewProfileResponse(string response)
        {
            this.message = response;
        }
        

       
    }
}