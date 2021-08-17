using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Auth.Requests;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using Newtonsoft.Json.Linq;

namespace backend_api.Data.User
{
    public interface IUserRepository
    {
        Task<Models.User.Users> GetUser(int userID);
        Task<Models.User.Users> GetUserByEmail(string email);
        
        Task<List<Models.User.Users>> GetUser(String name);

        Task<CreateUserResponse> CreateUser(GoogleSignInRequest request);
        
        Task<IEnumerable<Models.User.Users>> GetAllUsers();
        
        Task<ViewProfileResponse> ViewProfile(ViewProfileRequest request);

        Task<GetUserProfilesResponse> GetUserProfiles();

        Task<EditProfileResponse> EditProfile(EditProfileRequest request);

        List<string> GetAllUserEmails();

        Task<Models.User.Users> GetExistingUserDetails(GoogleSignInRequest request);
        
        Task<bool> checkEmailExists(GoogleSignInRequest request);

        ViewProfileResponse ViewProfileAsp(ViewProfileRequest request);

    }
}