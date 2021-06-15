using System.Threading.Tasks;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;

namespace backend_api.Services.User
{
    public interface IUserService
    {
        //function definitions go here and then get implemented in UserService.cs
        void verifyLogin();

        /**
        * This use case determines the current user based on the JWT token retrieved from the Google Oauth API when a user logs in. 
        *
        * @param req GetUserRequest object which reads a token and adds the data to its variables.
        * @return Returns a response containing a GetUserResponse object which contains getters for each attribute of the user (details obtained from GetUserRequest object).
        */
        CreateUserResponse CreateUser(CreateUserRequest request);
        GetUserResponse getUser(GetUserRequest request);


        Task<EditProfileResponse> EditProfile(EditProfileRequest request);

        ViewProfileResponse ViewProfile(ViewProfileRequest request);

    }
}