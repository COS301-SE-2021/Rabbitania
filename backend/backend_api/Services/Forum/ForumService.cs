using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.Forum;
using backend_api.Exceptions.Booking;
using backend_api.Exceptions.Forum;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Exceptions.Notifications;
using backend_api.Exceptions.User;
using backend_api.Models.Forum;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;
using backend_api.Models.Notification.Requests;
using backend_api.Services.Notification;
using backend_api.Services.User;
using Castle.Core.Internal;

namespace backend_api.Services.Forum
{
    public class ForumService : IForumService
    {
        private readonly IForumRepository _forumRepository;
        private readonly IUserService _userService;
        private readonly INotificationService _notificationService;
        public ForumService(IForumRepository forumRepository)
        {
            _forumRepository = forumRepository;
        }

        public ForumService(IForumRepository forumRepository, IUserService userService, INotificationService notificationService)
        {
            _forumRepository = forumRepository;
            _userService = userService;
            _notificationService = notificationService;
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
            
            var userEmails = _userService.GetAllUserEmails();
            var emailReq = new SendEmailNotificationRequest(
                "Forum Name: " + request.ForumTitle + "\n\n\nHey there Rabbit! \n\nSo a new forum has been created, do you think it interests you? \n\nIf so please check it out!",
                "New Forum Created!",
                userEmails
                );
            await _notificationService.SendEmailNotification(emailReq);

            var tfidf = new TFIDF.TFIDF();
            var titlesList = new List<string>();
            titlesList.Add("Stupid Question");
            titlesList.Add("2nd Thread Title Test");

            var bodiesList = new List<string>();
            bodiesList.Add("1st Thread Body Test");
            bodiesList.Add("2nd Thread body test");
            tfidf.tfidf_call(titlesList, bodiesList, "Dumb Question 1", "2nd Thread Body Test");
            
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

        public async Task<bool> CreateForumThreadAPI(CreateForumThreadRequest request)
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
                throw new InvalidUserIdException();
            }

            return await _forumRepository.CreateForumThreadApi(request);
        }

        public async Task<CreateForumThreadResponse> CreateForumThread(CreateForumThreadRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid CreateForumThreadRequest Object");
                }

                if (request.ForumId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ForumId");
                }

                if (request.ForumThreadTitle.IsNullOrEmpty())
                {
                    throw new InvalidForumTitleException("Invalid Forum Thread Title");
                }

                if (request.UserId == 0)
                {
                    throw new InvalidUserIdException("Invalid UserId");
                }

                return await _forumRepository.CreateForumThread(request);
            }
            catch (Exception)
            {
                return new CreateForumThreadResponse(HttpStatusCode.BadRequest);
            }
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
                    throw new InvalidForumRequestException("Invalid ForumThreadId");
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

        public async Task<DeleteThreadCommentResponse> DeleteThreadComment(DeleteThreadCommentRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid DeleteThreadCommentRequest object");
                }

                if (request.ThreadCommentId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ThreadCommentId");
                }

                return await _forumRepository.DeleteThreadComment(request);
            }
            catch (InvalidThreadContentException e)
            {
                return new DeleteThreadCommentResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<RetrieveNumThreadsResponse> RetrieveNumThreads(RetrieveNumThreadsRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid RetrieveNumThreadsRequest Object");
                }

                if (request.ForumId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ForumId");
                }

                return await _forumRepository.RetrieveNumThreads(request);
            }
            catch (InvalidForumRequestException e)
            {
                return new RetrieveNumThreadsResponse(HttpStatusCode.BadRequest);
            }
        }


        public async Task<EditForumResponse> EditForum(EditForumRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid EditForumRequest Object");
                }

                if (request.ForumId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ForumId");
                }

                return await _forumRepository.EditForum(request);
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
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid EditForumThreadRequest Object");
                }

                if (request.ForumThreadId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ForumThreadId");
                }

                return await _forumRepository.EditForumThread(request);
            }
            catch (InvalidForumRequestException)
            {
                return new EditForumThreadResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<EditThreadCommentResponse> EditThreadComment(EditThreadCommentRequest request)
        {
            try
            {
                if (request == null)
                {
                    throw new InvalidForumRequestException("Invalid EditThreadCommentRequest Object");
                }

                if (request.ThreadCommentId == 0)
                {
                    throw new InvalidForumRequestException("Invalid ThreadCommentId");
                }

                return await _forumRepository.EditThreadComment(request);
            }
            catch (InvalidForumRequestException)
            {
                return new EditThreadCommentResponse(HttpStatusCode.BadRequest);
            }
        }
    }
    
}