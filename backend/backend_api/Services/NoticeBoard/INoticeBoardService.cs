using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;

namespace backend_api.Services.NoticeBoard
{
    public interface INoticeBoardService
    {
        AddNoticeBoardThreadResponse AddNoticeBoardThread(AddNoticeBoardThreadRequest request);
    }
}