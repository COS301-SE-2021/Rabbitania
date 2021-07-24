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
    }
}