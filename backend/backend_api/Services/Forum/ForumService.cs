using System.Net;
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

        public async Task<RetrieveForumsResponse> RetrieveForums(RetrieveForumsRequest request)
        {
            RetrieveForumsResponse response = new RetrieveForumsResponse(
                await _forumRepository.RetrieveForums(request));
            if (request == null)
            {
                throw new InvalidForumRequestException("Invalid RetrieveForums Request");
            }

            return response;
        }

        public async Task<DeleteForumResponse> DeleteForum(DeleteForumRequest request)
        {
            if (request == null)
            {
                throw new InvalidForumRequestException("Invalid DeleteForumRequest Object");
            }

            if (request.ForumId == 0)
            {
                throw new InvalidForumRequestException("Invalid ForumId");
            }

            return await _forumRepository.DeleteForum(request);
        }

        public async Task<CreateForumThreadResponse> CreateForumThread(CreateForumThreadRequest request)
        {
            if (request == null)
            {
                throw new InvalidForumRequestException("Invalid CreateForumThreadRequest Object");
            }

            if (request.ForumId == 0)
            {
                throw new InvalidForumRequestException("Invalid ForumId");
            }

            if (request.UserId == 0)
            {
                throw new InvalidUserIdException("Invalid UserId");
            }

            return await _forumRepository.CreateForumThread(request);
        }

        public async Task<RetrieveForumThreadsResponse> RetrieveForumThreads(RetrieveForumThreadsRequest request)
        {
            if (request == null)
            {
                throw new InvalidForumRequestException("Invalid RetrieveForumThreadsRequest Object");
            }

            if (request.ForumId == 0)
            {
                throw new InvalidForumRequestException("Invalid ForumId");
            }

            return await _forumRepository.RetrieveForumThreads(request);
        }

        public async Task<DeleteForumThreadResponse> DeleteForumThread(DeleteForumThreadRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid DeleteForumThreadRequest Object");
                }

                if (request.ForumThreadId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ForumId");
                }
                
                return await _forumRepository.DeleteForumThread(request);
            }
            catch (InvalidForumRequestException e)
            {
                return new DeleteForumThreadResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<CreateThreadCommentResponse> CreateThreadComment(CreateThreadCommentRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid CreateThreadCommentRequest Object");
                }

                if (request.ForumThreadId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ThreadCommentId");
                }

                return await _forumRepository.CreateThreadComment(request);
            }
            catch (InvalidForumRequestException e)
            {
                return new CreateThreadCommentResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(RetrieveThreadCommentsRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid RetrieveThreadCommentsRequest");
                }

                if (request.ForumThreadId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ForumThread Id");
                }

                return await _forumRepository.RetrieveThreadComments(request);
            }
            catch (InvalidForumRequestException e)
            {
                return new RetrieveThreadCommentsResponse(HttpStatusCode.BadRequest);
            }
        }

    }
}