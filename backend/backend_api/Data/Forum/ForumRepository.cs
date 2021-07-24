using System.Net;
using System.Threading.Tasks;

using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;

namespace backend_api.Data.Forum
{
    public class ForumRepository : IForumRepository
    {
        private readonly IForumContext _forum;

        public ForumRepository(IForumContext forum)
        {
            _forum = forum;
        }

        public async Task<CreateForumResponse> CreateForum(CreateForumRequest request)
        {
            var forumTitle = request.ForumTitle;
            var createdDate = request.CreatedDate;
            var userId = request.UserId;

            var forum = new Models.Forum.Forums(forumTitle, userId, createdDate);

            _forum.Forums.Add(forum);
            await _forum.SaveChanges();
            
            return new CreateForumResponse(HttpStatusCode.Created);
        }
    }
}