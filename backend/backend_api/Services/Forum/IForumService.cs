using System.Threading.Tasks;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;

namespace backend_api.Services.Forum
{
    public interface IForumService
    {
        
        /// <summary>
        ///     Validates the request after which it will create a new Forum and store
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<CreateForumResponse> CreateForum(CreateForumRequest request);
        
        /// <summary>
        ///     Validates whether or not the request is valid 
        /// </summary>
        /// <param name="request"></param>
        /// <returns>An HTTPS status code stating whether the operation was successful or not</returns>
        Task<RetrieveForumsResponse> RetrieveForums(RetrieveForumsRequest request);

        Task<DeleteForumResponse> DeleteForum(DeleteForumRequest request);

        Task<CreateForumThreadResponse> CreateForumThread(CreateForumThreadRequest request);

        Task<RetrieveForumThreadsResponse> RetrieveForumThreads(RetrieveForumThreadsRequest request);

        Task<DeleteForumThreadResponse> DeleteForumThread(DeleteForumThreadRequest request);

        Task<CreateThreadCommentResponse> CreateThreadComment(CreateThreadCommentRequest request);

        Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(RetrieveThreadCommentsRequest request);

        Task<DeleteThreadCommentResponse> DeleteThreadComment(DeleteThreadCommentRequest request);

        Task<RetrieveNumThreadsResponse> RetrieveNumThreads(RetrieveNumThreadsRequest request);

        Task<EditForumResponse> EditForum(EditForumRequest request);

        Task<EditForumThreadResponse> EditForumThread(EditForumThreadRequest request);

        Task<EditThreadCommentResponse> EditThreadComment(EditThreadCommentRequest request);

        Task<bool> CreateForumThreadAPI(CreateForumThreadRequest request);
    }
}