using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;

namespace backend_api.Services.NoticeBoard
{
    public interface INoticeBoardService
    {
        
        /// <summary>
        /// Validates the request after which it will create a new noticeboard thread and
        /// store it in the database
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, after which it
        ///     returns a list of noticeboard threads currently held within
        ///     the database
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(RetrieveNoticeBoardThreadsRequest request);
    }
}