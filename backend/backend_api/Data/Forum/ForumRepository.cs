using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Exceptions.Forum;
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

        public async Task<List<Models.Forum.Forums>> RetrieveForums(RetrieveForumsRequest request)
        {
            List<Models.Forum.Forums> forums = _forum.Forums.ToList();
            return forums;
        }

        public async Task<DeleteForumResponse> DeleteForum(DeleteForumRequest request)
        {
            try
            {
                var forumToDelete = _forum.Forums.Find(request.ForumId);
                if (forumToDelete != null)
                {
                    _forum.Forums.Remove(forumToDelete);
                }
                else
                {
                    throw new InvalidForumRequestException("Forum ID not found in the database");
                }

                await _forum.SaveChanges();
                return new DeleteForumResponse(HttpStatusCode.Accepted);
            }
            catch (InvalidForumRequestException e)
            {
                return new DeleteForumResponse(HttpStatusCode.BadRequest);
            }
        }
    }
}