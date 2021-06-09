using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.User.Data
{
    public class UserRepository : DbContext, IUserRepository
    {
        private readonly IUserRepository _users;
        
        public UserRepository(IUserRepository users)
        {
            this._users = users;
        }

        public async Task<IAsyncEnumerable<Models.User.User>> GetUser(int userID)
        {
            
        }
        
        // public async Task<List<Notification>> RetrieveNotifications(int userID)
        // {
        //     IQueryable<Notification> retrieveUserNotifications = _context.Notifications.Where(notification => notification.UserId == userID);
        //     return await retrieveUserNotifications.ToListAsync();
        // }
        public async Task<List<Models.User.User>> GetAllUsers()
        {
            IQueryable<Models.User.User> getAllUsers = 
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