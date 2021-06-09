using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.User.Models.User;
using Microsoft.EntityFrameworkCore;

namespace backend_api.User.Data.User
{
    public interface IUserRepository
    {
        Task<IAsyncEnumerable<Models.User.User>> GetUser(int userID);
        
        Task<IAsyncEnumerable<Models.User.User>> GetAllUsers();

        Task<IAsyncEnumerable<Models.User.User>> AddUser(Models.User.User user);

        Task<IAsyncEnumerable<Models.User.User>> UpdateUser(Models.User.User user);

        Task<IAsyncEnumerable<Models.User.User>> DeleteUser(int userID);

        // DbSet<Models.User.User> users { get; set; }

        // Task<int> SaveChanges();

    }
}