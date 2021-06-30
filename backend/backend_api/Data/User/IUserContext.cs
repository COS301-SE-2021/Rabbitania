using System.Threading.Tasks;
using backend_api.Models.User;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public interface IUserContext
    {
        DbSet<Models.User.User> Users { get; set; }
        DbSet<UserEmails> UserEmail { get; set; }
        
        Task<int> SaveChanges();
    }
}