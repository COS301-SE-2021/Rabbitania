using System.Collections.Generic;
using backend_api.Models.User.Requests;

namespace backend_api.Models.User.Responses
{
    public class GetUserProfilesResponse
    {
        private IEnumerable<Users> _userProfiles;

        public GetUserProfilesResponse(IEnumerable<Users> userProfiles)
        {
            _userProfiles = userProfiles;
        }

        public IEnumerable<Users> UserProfiles
        {
            get => _userProfiles;
            set => _userProfiles = value;
        }
    }
}