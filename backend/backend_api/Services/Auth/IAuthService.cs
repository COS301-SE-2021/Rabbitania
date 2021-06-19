using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;
using Newtonsoft.Json.Linq;

namespace backend_api.Services.Auth
{
    public interface IAuthService
    {
        LoginResponse checkEmailExists(GoogleSignInRequest request);

        DomainResponse CheckEmailDomain(GoogleSignInRequest request);

        JObject GetUser(GoogleSignInRequest request);

    }
}