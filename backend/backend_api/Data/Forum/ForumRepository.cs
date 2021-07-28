using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Exceptions.Forum;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;
using Castle.Core.Internal;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Query;

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

            var forum = new Models.Forum.Forums(forumTitle, userId, createdDate);

            _forum.Forums.Add(forum);
            await _forum.SaveChanges();
            
            return new CreateForumResponse(HttpStatusCode.Created);
        }

        public async Task<List<Models.Forum.Forums>> RetrieveForums(RetrieveForumsRequest request)
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
            catch (InvalidForumRequestException e)
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

            var forumThread = new Models.Forum.ForumThreads(forumThreadTitle, userId, createdDate, imageUrl, forumId);

           
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
            catch (InvalidForumRequestException e)
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

                return new RetrieveForumThreadsResponse(await forumThreads.ToListAsync());
            }
            catch (InvalidForumRequestException e)
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
                new Models.Forum.ThreadComments(commentBody, createDate, imageUrl, likes, dislikes, forumThreadId, userId);

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
            catch (InvalidForumRequestException e)
            {
                return new CreateThreadCommentResponse(HttpStatusCode.BadRequest);
            }

            return new CreateThreadCommentResponse(HttpStatusCode.Created);
           
        }
    }
} 