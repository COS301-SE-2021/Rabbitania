using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace backend_api.Models
{
    public interface IUserContext
    {
        DbSet<User> users { get; set; }

        Task<int> SaveChanges();
    }
}