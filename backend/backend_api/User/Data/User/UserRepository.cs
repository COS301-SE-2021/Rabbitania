using System.Threading.Tasks;
using backend_api.Models;
using backend_api.User.Models;

namespace backend_api.User.Data.User
{
    public class UserRepository : IUserRepository
    {
        private readonly DatabaseContext _dbContext;
        
        public UserRepository(DatabaseContext DbContext)
        {
            this._dbContext = DbContext;
        }

        public async Task<Models.User.User[]> RetrieveUsers(int userID)
        {
            return;
        }
    }
}