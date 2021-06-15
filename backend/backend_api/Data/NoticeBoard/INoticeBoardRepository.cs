using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;

namespace backend_api.Data.NoticeBoard
{
    public interface INoticeBoardRepository
    {
        public AddNoticeBoardThreadResponse AddNoticeBoardThread(AddNoticeBoardThreadRequest request);
    }
}