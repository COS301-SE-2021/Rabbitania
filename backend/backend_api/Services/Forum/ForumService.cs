using System.Threading.Tasks;
using backend_api.Data.Forum;
using backend_api.Exceptions.Forum;
using backend_api.Exceptions.Notifications;
using backend_api.Models.Forum;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;
using Castle.Core.Internal;

namespace backend_api.Services.Forum
{
    public class ForumService : IForumService
    {
        private readonly IForumRepository _forumRepository;

        public ForumService(IForumRepository forumRepository)
        {
            _forumRepository = forumRepository;
        }

        public async Task<CreateForumResponse> CreateForum(CreateForumRequest request)
        {
            if (request == null)
            {
                throw new InvalidForumRequestException("Invalid CreateForum object");
            }

            if (request.ForumTitle.IsNullOrEmpty())
            {
                throw new InvalidForumTitleException("The Forum title cannot be null or empty");
            }

            if (request.UserId <= 0)
            {
                throw new InvalidUserIdException("UserID is invalid");
            }

            return await _forumRepository.CreateForum(request);
        }
        
    }
}