using System.Threading.Tasks;
using backend_api.Models.Auth;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using Newtonsoft.Json.Linq;

namespace backend_api.Services.Auth
{
    public interface IAuthService
    {
        /// <summary>
        ///     Validates whether or not a sign in request contains a valid email address
        ///     returns thereafter a response with a boolean set to true, for valid, 
        ///     or false, for invalid.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Response object with a set boolean parameter</returns>
        Task<LoginResponse> checkEmailExists(GoogleSignInRequest request);

        /// <summary>
        ///     Validates whether or not a sign in request contains a valid email address domain
        ///     returns thereafter a response with a boolean set to true, for valid, 
        ///     or false, for invalid.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Response object with a set boolean parameter</returns>
        DomainResponse CheckEmailDomain(GoogleSignInRequest request);

        /// <summary>
        ///     Checks if the user being requested is registered in the system
        ///     returns thereafter a Json object with the user details
        /// </summary>
        /// <param name="request"></param>
        /// <returns>Json object</returns>
        JObject GetUser(GoogleSignInRequest request);
        
        /// <summary>
        ///     Checks if a user exists in the system with the given name
        ///     returns thereafter a user object.
        /// </summary>
        /// <param name="name"></param>
        /// <returns>User object</returns>
        Task<Models.User.Users> GetUserName(string name);
        
        /// <summary>
        ///     Checks if a user exists in the system with the given request
        ///     parameters.
        ///     returns thereafter a user object.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>User object</returns>
        Task<Models.User.Users> GetUserId(GoogleSignInRequest request);
        
        /// <summary>
        ///     Validates whether or not the user with the supplied details is
        ///     and admin or not.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>User Object</returns>
        Task<Models.User.Users> GetUserAdminStatus(GoogleSignInRequest request);
        
        /// <summary>
        ///     Validates whether the user with the supplied credentials
        ///     exists within our system therefore meaning they are a
        ///     Retro Rabbit employee.
        /// </summary>
        /// <param name="credentials"></param>
        /// <returns>Returns a bool</returns>
        Task<bool> Validate(Credentials credentials);
        
    }
    
}