using System;

namespace backend_api.Models.User.Responses
{
    public class ViewProfileResponse
    {
        public ViewProfileResponse(string message, string name, string userImage, string description, string phoneNumber, int empLevel, UserRoles userRole, OfficeLocation officeLocation)
        {
            this.message = message;
            this.name = name;
            this.userImage = userImage;
            this.description = description;
            this.phoneNumber = phoneNumber;
            this.empLevel = empLevel;
            this.officeLocation = officeLocation;
            this.userRoles = userRole;
        }

        public string message { get; set; }
        public string name { get; set; }
        public string userImage { get; set; }
        public string description { get; set; }
        public string phoneNumber { get; set; }
        public int empLevel { get; set; }
        public OfficeLocation officeLocation { get; set; }
        public UserRoles userRoles { get; set; }

        public ViewProfileResponse(string response)
        {
            this.message = response;
        }
        

       
    }
}