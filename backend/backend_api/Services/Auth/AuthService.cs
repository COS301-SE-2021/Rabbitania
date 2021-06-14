using backend_api.Data.User;
using backend_api.Models.Auth.Requests;
using backend_api.Models.Auth.Responses;

namespace backend_api.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly IUserRepository _repository;

        public GoogleResponse GoogleAuthResponse(GoogleSignInRequest request)
        {
            throw new System.NotImplementedException();
        }

        public AuthService(IUserRepository repository)
        {
            this._repository = repository;
        }
    }
}