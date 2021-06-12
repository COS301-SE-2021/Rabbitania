using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public interface IUserEmailsContext
    {
        DbSet<Models.User.UserEmails> emails { get; set; }
        Task<int> SaveChanges();
        
        
    }
}