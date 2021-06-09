using System.Collections.Generic;
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

        public async Task<IAsyncEnumerable<Models.User.User>> GetUser(int userID)
        {
            
        }

        public async Task<IAsyncEnumerable<Models.User.User>> GetAllUsers()
        {
            
        }

        public async Task<IAsyncEnumerable<Models.User.User>> DeleteUser(int userID)
        {
            
        }

        public async Task<IAsyncEnumerable<Models.User.User>> AddUser(Models.User.User User)
        {
                        
        }

        public async Task<IAsyncEnumerable<Models.User.User>> UpdateUser(Models.User.User User)
        {
            
        }
        // public DbSet<Models.User.User> users { get; set; }
    }
}