using System.Threading.Tasks;
using backend_api.User.Models.User;
using Microsoft.EntityFrameworkCore;

namespace backend_api.User.Data.User
{
    public interface IUserRepository
    {
        Task<Models.User.User[]> RetrieveUsers(int userID);
        DbSet<Models.User.User> users { get; set; }

        // Task<int> SaveChanges();

    }
}