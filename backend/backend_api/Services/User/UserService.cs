using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Notifications;
using backend_api.Exceptions.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.Notification;
using Castle.Core.Internal;
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
        
        public async Task<GetUserResponse> GetUserByID(GetUserByIDRequest request)
        {
            var user = await _userRepository.GetUser(request.UserId);
            if (!user.Equals(null))
            {
                return new GetUserResponse(user, user.Name,user.EmployeeLevel,user.IsAdmin,user.UserDescription,user.UserId,user.PhoneNumber,user.UserRole,user.UserImgUrl,user.OfficeLocation,user.PinnedUserIds);
            }
            else
            {
                throw new InvalidUserRequestException("User does not exist");
            }
        }
        public async Task<GetUserResponse> GetUserByEmail(GetUserByEmailRequest request)
        {
            var user = await _userRepository.GetUserByEmail(request.Email);
            if (!user.Equals(null))
            {
                return new GetUserResponse(user, user.Name,user.EmployeeLevel,user.IsAdmin,user.UserDescription,user.UserId,user.PhoneNumber,user.UserRole,user.UserImgUrl,user.OfficeLocation,user.PinnedUserIds);
            }
            else
            {
                throw new InvalidUserRequestException("User does not exist");
            }
        }

        public async Task<EditProfileResponse> EditProfile(EditProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            if (request.UserId <= 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }
            
            return await _userRepository.EditProfile(request);
        }
        
        public async Task<ViewProfileResponse> ViewProfile(ViewProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            if (request.UserId.Equals(null))
            {
                throw new Exception("Error Missing UserID");
            }
            
            ViewProfileResponse returnObject = await _userRepository.ViewProfile(request);
            if (returnObject._name == null)
            {
                throw new InvalidUserRequestException("User does not exist");
            }

            return returnObject;
        }
        public async Task<ViewProfileResponse> ViewProfileAsp(ViewProfileRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }
            if (request.UserId.Equals(null))
            {
                throw new Exception("Error Missing UserID");
            }
            return _userRepository.ViewProfileAsp(request);
        }

        public async Task<GetUserProfilesResponse> GetUserProfiles(GetUserProfilesRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }

            return await _userRepository.GetUserProfiles();
        }

        public List<string> GetAllUserEmails()
        {
            var response = _userRepository.GetAllUserEmails();
            if (response.IsNullOrEmpty())
            {
                throw new Exception("Error with user emails");
            }

            return response;
        }

        public async Task<MakeUserAdminResponse> MakeUserAdmin(MakeUserAdminRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request object cannot be null");
            }

            if (request.UserId.Equals(null))
            {
                throw new Exception("Error Missing UserID");
            }

            return await _userRepository.MakeUserAdmin(request);
        }

        public async Task<CheckAdminStatusResponse> CheckAdmin(CheckAdminStatusRequest request)
        {
            if (request == null)
            {
                throw new InvalidUserRequestException("Request is null");
            }

            if (request.UserEmail == null || request.UserEmail.Length <= 0)
            {
                throw new InvalidUserRequestException("Request email is null or empty");
            }

            var email = request.UserEmail;
            try
            {
                var user = await _userRepository.GetUserByEmail(email);
                if (user.IsAdmin)
                {
                    return new CheckAdminStatusResponse(true, HttpStatusCode.OK);
                }
                else
                {
                    return new CheckAdminStatusResponse(false, HttpStatusCode.OK);
                }
            }
            catch (Exception e)
            {
                return new CheckAdminStatusResponse(HttpStatusCode.BadRequest);
            }
        }

    }
}