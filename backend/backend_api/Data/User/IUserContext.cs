using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.User
{
    public interface IUserContext
    {
        DbSet<Models.User.User> users { get; set; }
        Task<int> SaveChanges();
    }
}