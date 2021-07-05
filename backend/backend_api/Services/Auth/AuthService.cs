using System;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Exceptions.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using Newtonsoft.Json.Linq;

namespace backend_api.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository _repository;

        public async Task<LoginResponse> checkEmailExists(GoogleSignInRequest request)
        {
            // throw new System.NotImplementedException();
            String email = request.Email;
            if (email == null)
            {
                throw new NullEmailException("User Email Missing");
            }
            //Checks if email received by request is in the UserEmails repo
            if(_repository.checkEmailExists(request).Result)
            {
                return new LoginResponse(true);
            }
            else
            {
                return new LoginResponse(false);
            }
        }

        public AuthService(IUserRepository repository)
        {
            this._repository = repository;
        }

        public DomainResponse CheckEmailDomain(GoogleSignInRequest request)
        {
            var email = request.Email;
            var arr = email.Split('@');
            //TODO: Change to retrorabbit.co.za once we have a test email to work with
            if (arr[1].Equals("tuks.co.za"))
            {
                return new DomainResponse(true);
            }
            else
            {
                return new DomainResponse(false);
            }
        }
        public JObject GetUser(GoogleSignInRequest request)
        {
            var user = _repository.GetExistingUserDetails(request).Result;
            JObject json = new JObject(
                new JProperty("description", user.UserDescription),
                new JProperty("pinnedIDs", user.PinnedUserIds.ToArray()),
                new JProperty("admin", user.IsAdmin),
                new JProperty("role", user.UserRole.ToString()),
                new JProperty("empLevel", user.EmployeeLevel),
                new JProperty("office", user.OfficeLocation.ToString()));

            return json;
        }

        public async Task<Models.User.Users> GetUserName(string name)
        {
            var UserName = name;

            var resp = await _repository.GetUser(name);
            var user = resp.FirstOrDefault();
            return user;
        }

        public async Task<Models.User.Users> GetUserID(GoogleSignInRequest request)
        {
            var user = await _repository.GetExistingUserDetails(request);
            return user;
        }

        
    }
    
}