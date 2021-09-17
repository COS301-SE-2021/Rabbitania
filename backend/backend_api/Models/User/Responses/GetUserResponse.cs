using System;
using System.Collections.Generic;
using backend_api.Models.Enumerations;

namespace backend_api.Models.User.Responses
{
    public class GetUserResponse
    {
        private String _response { get; set; }
        private String _name { get; set; }
        private List<int> _pinnedIDs { get; set; }
        private int _userID { get; set; }
        private string _phoneNumber { get; set; }
        private String _userImage { get; set; }
        private String _description { get; set; }
        private bool _isAdmin { get; set; }
        private int _empLevel { get; set; }
        private UserRoles _UserRole { get; set; }
        private OfficeLocation _OfficeLocation { get; set; }
        
        private Models.User.Users _user;
        public GetUserResponse(String resp)
        {
            this._response = resp;
        }

        public GetUserResponse(Models.User.Users user, String name, int emplvl, bool isadmin, String desc, int userid, string number, UserRoles role, String image, OfficeLocation office, List<int> pinnedids)
        {
            this._description = desc;
            this._UserRole = role;
            this._name = name;
            this._empLevel = emplvl;
            this._isAdmin = isadmin;
            this._userID = userid;
            this._phoneNumber = number;
            this._userImage = image;
            this._OfficeLocation = office;
            for (int i = 0; i < pinnedids.Count; i++)
                this._pinnedIDs[i] = pinnedids[i];
            
            this._user = user;

        }
    }
}