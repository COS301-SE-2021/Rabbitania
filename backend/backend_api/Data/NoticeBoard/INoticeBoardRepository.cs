using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;

namespace backend_api.Data.NoticeBoard
{
    public interface INoticeBoardRepository
    {
        /// <summary>
        ///     Adds a notice board thread to the noticeboard
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTP success Response</returns>
        Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request);

        /// <summary>
        ///     Retrieves all notice board threads currently held within the database
        /// </summary>
        /// <param name="request"></param>
        /// <returns>A list of notice board threads</returns>
        Task<List<Models.NoticeBoard.NoticeBoard>> RetrieveAllNoticeBoardThreads(RetrieveNoticeBoardThreadsRequest request);

        /// <summary>
        ///     Deletes a notice board thread specified by the noticeboard thread passed into the delete function
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTP response on whether it was a successful or not</returns>
        Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(DeleteNoticeBoardThreadRequest request);
    }
}