using System;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Notifications;
using backend_api.Exceptions.User;
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

        public async Task<CreateUserResponse> CreateUser(GoogleSignInRequest request)
        {
            return await _userRepository.CreateUser(request);
        }

        public GetUserResponse getUser(GetUserRequest request)
        {
            //TODO: implement GetUSerResponse to use the jwt token from google login API
            //JsonWebToken token = request.getToken();
            //String email = token.getEmail();

            String name = request.getName();
           
            //search for user
            Models.User.Users user = _userRepository.GetUser(name).Result[0];
            
            GetUserResponse response = new GetUserResponse(user, name, user.EmployeeLevel, user.IsAdmin, user.UserDescription, user.UserId, user.PhoneNumber, user.UserRole, user.UserImgUrl, user.OfficeLocation, user.PinnedUserIds);
            return response;
        }

        public Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequest("Request object cannot be null");
            }
            if (request.UserId <= 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            
            return _userRepository.EditProfile(request);
        }
        
        public async Task<ViewProfileResponse> ViewProfile(ViewProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequest("Request object cannot be null");
            }
            if (request.UserId.Equals(null))
            {
                throw new Exception("Error Missing UserID");
            }
            
            ViewProfileResponse returnObject = _userRepository.ViewProfile(request);
            if (returnObject.name == null)
            {
                throw new InvalidUserRequest("User does not exist");
            }

            return returnObject;
        }

        public async Task<GetUserProfilesResponse> GetUserProfiles(GetUserProfilesRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequest("Request object cannot be null");
            }

            return await _userRepository.GetUserProfiles();
        }
    }
}