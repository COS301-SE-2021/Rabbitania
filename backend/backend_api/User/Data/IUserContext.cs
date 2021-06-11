using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.User.Data
{
    public interface IUserContext
    {
        DbSet<Models.User.User> users { get; set; }
        Task<int> SaveChanges();
    }
}