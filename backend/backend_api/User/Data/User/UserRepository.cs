using backend_api.Models;

namespace backend_api.User.Data.User
{
    public class UserRepository : IUserRepository
    {
        private readonly DatabaseContext _dbContext;
        
        public UserRepository(DatabaseContext DbContext)
        {
            this._dbContext = DbContext;
        } 
    }
}