using System;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using Newtonsoft.Json.Linq;

namespace backend_api.Services.User
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

        public CreateUserResponse CreateUser(CreateUserRequest request)
        {
            return _userRepository.CreateUser(request);
        }

        public GetUserResponse getUser(GetUserRequest request)
        {
            //TODO: implement GetUSerResponse to use the jwt token from google login API
            //JsonWebToken token = request.getToken();
            //String email = token.getEmail();

            String firstname = request.getName();
            String lastname = request.getSurname();
            //search for user
            Models.User.User user = _userRepository.GetUser(firstname, lastname).Result[0];
            
            GetUserResponse response = new GetUserResponse(user, firstname, lastname, user.employeeLevel, user.isAdmin, user.userDescription, user.UserID, user.phoneNumber, user.userRole, user.userImage, user.officeLocation, user.pinnedUserIDs);
            return response;
        }

        public Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            if (request.UserId.Equals(null))
            {
                throw new Exception("Error missing UserID");
            }
            
            return _userRepository.EditProfile(request);
        }
        
        public ViewProfileResponse ViewProfile(ViewProfileRequest request)
        {

            if (request.UserId.Equals(null))
            {
                throw new Exception("UserID Missing");
            }
            return _userRepository.ViewProfile(request);
            

        }

        
    }
}