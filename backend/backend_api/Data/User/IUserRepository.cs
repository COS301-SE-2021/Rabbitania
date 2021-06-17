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
        Task<List<Models.User.User>> GetUser(int userID);

        Task<List<Models.User.User>> GetUser(String firstname, String lastname);

        CreateUserResponse CreateUser(CreateUserRequest request);
        
        Task<IEnumerable<Models.User.User>> GetAllUsers();
        
        ViewProfileResponse ViewProfile(ViewProfileRequest request);

        // Task<IAsyncEnumerable<Models.User.User>> AddUser(Models.User.User user);
        //
        // Task<IAsyncEnumerable<Models.User.User>> UpdateUser(Models.User.User user);
        //
        // Task<IAsyncEnumerable<Models.User.User>> DeleteUser(int userID);
        
        // Task<int> SaveChanges();
        CreateEmailResponse CreateUserEmail(CreateUserRequest userRequest, CreateEmailRequest emailRequest);

        Task<EditProfileResponse> EditProfile(EditProfileRequest request);

        Task<Models.User.User> GetExistingUserDetails(GoogleSignInRequest request);
        bool checkEmailExists(GoogleSignInRequest request);
    }
}