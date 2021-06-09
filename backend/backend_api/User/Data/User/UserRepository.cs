using System.Threading.Tasks;
using backend_api.Models;
using backend_api.User.Models;
using Microsoft.EntityFrameworkCore;

namespace backend_api.User.Data.User
{
    public class UserRepository : IUserRepository
    {
        private readonly IUserRepository _users;
        
        public UserRepository(IUserRepository users)
        {
            this._users = users;
        }

        public async Task<Models.User.User[]> RetrieveUsers(int userID)
        {
            return await this.RetrieveUsers(userID);
        }
        public DbSet<Models.User.User> users { get; set; }
    }
}