using System;
using backend_api.User.Data;
using backend_api.User.Models.Requests;
using backend_api.User.Models.Responses;
using Microsoft.IdentityModel.JsonWebTokens;

namespace backend_api.User.Services
{
    public class UserService: IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepo)
        {
            _userRepository = userRepo;
        }
        
        //Logical functions
        public void verifyLogin()
        {
            
        }

        public GetUserResponse getUser(GetUserRequest request)
        {
            //TODO: implement GetUSerResponse to use the jwt token from google login API
            //JsonWebToken token = request.getToken();
            //String email = token.getEmail();

            String email = request.getEmail();
            //search for user
            Models.User.User user = _userRepository.GetUser();
            GetUserResponse response = new GetUserResponse();
        }
    }
}