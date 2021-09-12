using System.ComponentModel;
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
        /// <returns> AddNoticeBoardThreadResponse </returns>
        Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, after which it
        ///     returns a list of noticeboard threads currently held within
        ///     the database
        /// </summary>
        /// <param name="request"></param>
        /// <returns> RetrieveNoticeBoardThreadsResponse </returns>
        Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(RetrieveNoticeBoardThreadsRequest request);
        
        
        /// <summary>
        ///     Validates whether or not the request is valid, after which it
        ///     deletes the threads in the repository and passes through a
        ///     response successfully or not successful.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> DeleteNoticeBoardThreadResponse </returns>
        Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(DeleteNoticeBoardThreadRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid, after which it
        ///     edits a noticeboard thread.
        /// </summary>
        /// <param name="request"></param>
        /// <returns> EditNoticeBoardThreadResponse </returns>
        Task<EditNoticeBoardThreadResponse> EditNoticeBoardThread(EditNoticeBoardThreadRequest request);

        /// <summary>
        ///     Increases the selected emoji based on the request object
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<IncreaseEmojiResponse> IncreaseEmoji(IncreaseEmojiRequest request);

        /// <summary>
        ///     Decreases the selected emoji based on the request object
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        Task<DecreaseEmojiResponse> DecreaseEmoji(DecreaseEmojiRequest request);



    }
}