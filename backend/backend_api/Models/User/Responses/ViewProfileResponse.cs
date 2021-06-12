using System;

namespace backend_api.Models.User.Responses
{
    public class ViewProfileResponse
    {
        public ViewProfileResponse(string message, string firstName, string lastname, string userImage, string description, int phoneNumber, int empLevel, int userRole, int officeLocation)
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

        private string message { get; set; }
        private string firstName { get; set; }
        private string lastname { get; set; }
        private string userImage { get; set; }
        private string description { get; set; }
        private int phoneNumber { get; set; }
        private int empLevel { get; set; }
        private int officeLocation { get; set; }
        private int userRoles { get; set; }

        public ViewProfileResponse(string response)
        {
            this.message = response;
        }
        

       
    }
}