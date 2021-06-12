using backend_api.User.Models.Requests;
using backend_api.User.Models.Responses;

namespace backend_api.User.Services
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
        GetUserResponse getUser(GetUserRequest request);

    }
}