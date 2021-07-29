
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Exceptions.Forum;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.Forum;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;
using Castle.Core.Internal;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.Forum
{
    public class ForumRepository : IForumRepository
    {
        private readonly IForumContext _forum;

        public ForumRepository(IForumContext forum)
        {
            _forum = forum;
        }

        //Forum Repository
        public async Task<CreateForumResponse> CreateForum(CreateForumRequest request)
        {
            var forumTitle = request.ForumTitle;
            var createdDate = request.CreatedDate;
            var userId = request.UserId;

            var forum = new Forums(forumTitle, userId, createdDate);

            _forum.Forums.Add(forum);
            await _forum.SaveChanges();
            
            return new CreateForumResponse(HttpStatusCode.Created);
        }

        public async Task<List<Forums>> RetrieveForums(RetrieveForumsRequest request)
        {
            var forums = _forum.Forums.ToList();
            return forums;
        }

        public async Task<DeleteForumResponse> DeleteForum(DeleteForumRequest request)
        {
            try
            {
                var forumToDelete = await _forum.Forums.FindAsync(request.ForumId);
                if (forumToDelete != null)
                {
                    _forum.Forums.Remove(forumToDelete);
                }
                else
                {
                    throw new InvalidForumRequestException("Forum does not exist in the database");
                }

                await _forum.SaveChanges();
                return new DeleteForumResponse(HttpStatusCode.Accepted);
            }
            catch (InvalidForumRequestException)
            {
                return new DeleteForumResponse(HttpStatusCode.BadRequest);
            }
        }
        
        //ForumThread Repository
        public async Task<CreateForumThreadResponse> CreateForumThread(CreateForumThreadRequest request)
        {
            var forumThreadTitle = request.ForumThreadTitle;
            var createdDate = request.CreatedDate;
            var imageUrl = request.ImageUrl;
            var userId = request.UserId;
            var forumId = request.ForumId;

            var forumThread = new ForumThreads(forumThreadTitle, userId, createdDate, imageUrl, forumId);

           
            try
            {
                var foreignForumId = await _forum.Forums.FindAsync(forumId);
                if (foreignForumId == null)
                {
                    throw new InvalidForumRequestException("Forum does not exist in the database");
                }
                _forum.ForumThreads.Add(forumThread);
                await _forum.SaveChanges();
            }
            catch (InvalidForumRequestException)
            {
                return new CreateForumThreadResponse(HttpStatusCode.BadRequest);
            }

            return new CreateForumThreadResponse(HttpStatusCode.Created);


        }

        public async Task<RetrieveForumThreadsResponse> RetrieveForumThreads(RetrieveForumThreadsRequest request)
        {
            var forumThreads = _forum.ForumThreads.Where(id => id.ForumId == request.ForumId);

            try
            {
                if (forumThreads.ToList().IsNullOrEmpty())
                {
                    throw new InvalidForumRequestException(
                        "Cannot retrieve forum threads for a forum that does not exist");
                }

                return new RetrieveForumThreadsResponse(await forumThreads.ToListAsync(), HttpStatusCode.Accepted);
            }
            catch (InvalidForumRequestException)
            {
                return new RetrieveForumThreadsResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<DeleteForumThreadResponse> DeleteForumThread(DeleteForumThreadRequest request)
        {
            try
            {
                var forumThreadToDelete = await _forum.ForumThreads.FindAsync(request.ForumThreadId);
                if (forumThreadToDelete != null)
                {
                    _forum.ForumThreads.Remove(forumThreadToDelete);
                }
                else
                {
                    throw new InvalidForumRequestException("Forum Thread does not exist");
                }

                await _forum.SaveChanges();
                return new DeleteForumThreadResponse(HttpStatusCode.Accepted);
            }
            catch (InvalidForumRequestException e)
            {
                return new DeleteForumThreadResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<CreateThreadCommentResponse> CreateThreadComment(CreateThreadCommentRequest request)
        {
            var commentBody = request.CommentBody;
            var createDate = request.CreatedDate;
            var imageUrl = request.ImageUrl;
            var likes = request.Likes;
            var dislikes = request.Dislikes;
            var forumThreadId = request.ForumThreadId;
            var userId = request.UserId;
            
            var threadComment =
                new ThreadComments(commentBody, createDate, imageUrl, likes, dislikes, forumThreadId, userId);

            try
            {
                var foreignForumId = await _forum.Forums.FindAsync(forumThreadId);
                if (foreignForumId == null)
                {
                    throw new InvalidForumRequestException("Forum does not exist in the database");
                }
                _forum.ThreadComments.Add(threadComment);
                await _forum.SaveChanges();
            }
            catch (InvalidForumRequestException)
            {
                return new CreateThreadCommentResponse(HttpStatusCode.BadRequest);
            }

            return new CreateThreadCommentResponse(HttpStatusCode.Created);
           
        }

        public async Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(RetrieveThreadCommentsRequest request)
        {
            var threadComments = _forum.ThreadComments.Where(id => id.ForumThreadId == request.ForumThreadId);
            try
            {
                if (threadComments.ToList().IsNullOrEmpty())
                {
                    throw new InvalidForumRequestException(
                        "Cannot retrieve Thread Comments for a thread that does not exist");
                }

                return new RetrieveThreadCommentsResponse(await threadComments.ToListAsync());
            }
            catch(InvalidForumRequestException)
            {
                return new RetrieveThreadCommentsResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<DeleteThreadCommentResponse> DeleteThreadComment(DeleteThreadCommentRequest request)
        {
            try
            {
                var threadCommentToDelete = await _forum.ThreadComments.FindAsync(request.ThreadCommentId);
                if (threadCommentToDelete != null)
                {
                    _forum.ThreadComments.Remove(threadCommentToDelete);
                }
                else
                {
                    throw new InvalidForumRequestException("Thread Comment does not exist");
                }

                await _forum.SaveChanges();
                return new DeleteThreadCommentResponse(HttpStatusCode.Accepted);
            }
            catch (InvalidThreadContentException)
            {
                return new DeleteThreadCommentResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<RetrieveNumThreadsResponse> RetrieveNumThreads(RetrieveNumThreadsRequest request)
        {
            try
            {
                var forumThreads = _forum.ForumThreads.Where(id => id.ForumId == request.ForumId);
                if (forumThreads.ToList().IsNullOrEmpty())
                {
                    throw new InvalidForumRequestException("There are currently no threads stored in this Forum");
                }
                else
                {
                    var threadsList = forumThreads.ToList();
                    return new RetrieveNumThreadsResponse(threadsList.Count, HttpStatusCode.Accepted);
                }

            }
            catch (InvalidForumRequestException)
            {
                return new RetrieveNumThreadsResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<EditForumResponse> EditForum(EditForumRequest request)
        {
            try
            {
                var forumToEdit = await _forum.Forums.FindAsync(request.ForumId);
                if (forumToEdit == null)
                {
                    throw new InvalidForumRequestException("Forum is not present in the database");
                }

                forumToEdit.ForumTitle = request.ForumTitle;
                _forum.Forums.Update(forumToEdit).State = EntityState.Modified;
                await _forum.SaveChanges();
                return new EditForumResponse(HttpStatusCode.Accepted);
            }
            catch (InvalidForumRequestException)
            {
                return new EditForumResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<EditForumThreadResponse> EditForumThread(EditForumThreadRequest request)
        {
            try
            {
                var forumThreadToEdit = await _forum.ForumThreads.FindAsync(request.ForumThreadId);
                if (forumThreadToEdit == null)
                {
                    throw new InvalidForumRequestException("Forum Thread is not present in the database");
                }

                forumThreadToEdit.ForumThreadTitle = request.ForumThreadTitle;
                forumThreadToEdit.imageURL = request.ImageUrl;

                _forum.ForumThreads.Update(forumThreadToEdit).State = EntityState.Modified;
                await _forum.SaveChanges();
                return new EditForumThreadResponse(HttpStatusCode.Accepted);
            }
            catch (InvalidForumRequestException)
            {
                return new EditForumThreadResponse(HttpStatusCode.BadRequest);
            }
        }
    }
} 