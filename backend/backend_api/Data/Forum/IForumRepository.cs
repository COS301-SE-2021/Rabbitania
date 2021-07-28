using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;

namespace backend_api.Data.Forum
{
    public interface IForumRepository
    {
        Task<CreateForumResponse> CreateForum(CreateForumRequest request);

        Task<List<Models.Forum.Forums>> RetrieveForums(RetrieveForumsRequest request);

        Task<DeleteForumResponse> DeleteForum(DeleteForumRequest request);

        Task<CreateForumThreadResponse> CreateForumThread(CreateForumThreadRequest request);

        Task<RetrieveForumThreadsResponse> RetrieveForumThreads(RetrieveForumThreadsRequest request);

        Task<DeleteForumThreadResponse> DeleteForumThread(DeleteForumThreadRequest request);

        Task<CreateThreadCommentResponse> CreateThreadComment(CreateThreadCommentRequest request);

        Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(RetrieveThreadCommentsRequest request);
    }
}