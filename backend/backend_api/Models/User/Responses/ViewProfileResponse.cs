using System;
using System.Net;
using backend_api.Models.Enumerations;
using Microsoft.AspNetCore.Http;

namespace backend_api.Models.User.Responses
{
    public class ViewProfileResponse
    {
        public ViewProfileResponse(HttpStatusCode message, string name, string userImage, string description, string phoneNumber, int empLevel, UserRoles userRole, OfficeLocation officeLocation)
        {
            this._response = message;
            this._name = name;
            this._userImage = userImage;
            this._description = description;
            this._phoneNumber = phoneNumber;
            this._empLevel = empLevel;
            this._officeLocation = officeLocation;
            this._userRoles = userRole;
        }

        public HttpStatusCode _response { get; set; }
        public string _name { get; set; }
        public string _userImage { get; set; }
        public string _description { get; set; }
        public string _phoneNumber { get; set; }
        public int _empLevel { get; set; }
        public OfficeLocation _officeLocation { get; set; }
        public UserRoles _userRoles { get; set; }

        public ViewProfileResponse(HttpStatusCode response)
        {
            this._response = response;
        }
        

       
    }
}