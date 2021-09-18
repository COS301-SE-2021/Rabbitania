using System;
using System.Collections.Generic;
using backend_api.Models.Enumerations;

namespace backend_api.Models.User.Responses
{
    public class GetUserResponse
    {
        private String response { get; set; }
        private String name { get; set; }
        private List<int> pinnedIDs { get; set; }
        private int userID { get; set; }
        private string phoneNumber { get; set; }
        private String userImage { get; set; }
        private String description { get; set; }
        private bool isAdmin { get; set; }
        private int empLevel { get; set; }
        private UserRoles UserRole { get; set; }
        private OfficeLocation OfficeLocation { get; set; }
        
        private Models.User.Users user;
        public GetUserResponse(String resp)
        {
            this.response = resp;
        }

        public GetUserResponse(Models.User.Users user, String name, int emplvl, bool isadmin, String desc, int userid, string number, UserRoles role, String image, OfficeLocation office, List<int> pinnedids)
        {
            this.description = desc;
            this.UserRole = role;
            this.name = name;
            this.empLevel = emplvl;
            this.isAdmin = isadmin;
            this.userID = userid;
            this.phoneNumber = number;
            this.userImage = image;
            this.OfficeLocation = office;
            for (int i = 0; i < pinnedids.Count; i++)
                this.pinnedIDs[i] = pinnedids[i];
            
            this.user = user;

        }
        
    }
}