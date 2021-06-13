using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.NoticeBoard
{
    public interface INoticeBoardContext
    {
        DbSet<Models.NoticeBoard.NoticeBoard> NoticeBoard { get; set; }
        Task<int> SaveChanges();
    }
}