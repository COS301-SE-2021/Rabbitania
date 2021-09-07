using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Node
{
    public class NodeContext : DbContext, INodeContext
    {
        public NodeContext(DbContextOptions<NodeContext> options) : base(options)
        {
        }

        protected NodeContext()
        {
        }
        public DbSet<Models.Node.Node> Nodes { get; set; }
        public new async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}