using backend_api.User.Data.User;

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
    }
}