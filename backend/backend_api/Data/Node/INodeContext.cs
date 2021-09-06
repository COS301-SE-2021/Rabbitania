using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Node
{
    public interface INodeContext
    {
        DbSet<Models.Node.Node> Nodes { get; set; }
        Task<int> SaveChanges();
    }
}