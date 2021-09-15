using System;
using System.Net;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Exceptions.Notifications;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Models.Notification.Requests;
using backend_api.Services.Notification;
using backend_api.Services.User;
using Castle.Core.Internal;
using Xunit.Sdk;

namespace backend_api.Services.NoticeBoard
{
    public class NoticeBoardService : INoticeBoardService
    {
        //GetAllUserEmails()
        private readonly INoticeBoardRepository _noticeBoardRepository;
        private readonly IUserService _userService;
        private readonly INotificationService _notificationService;
        public NoticeBoardService(INoticeBoardRepository noticeBoardRepo)
        {
            _noticeBoardRepository = noticeBoardRepo;
        }

        public NoticeBoardService(INoticeBoardRepository noticeBoardRepository, IUserService userService, INotificationService notificationService)
        {
            _noticeBoardRepository = noticeBoardRepository;
            _userService = userService;
            _notificationService = notificationService;
        }

        public NoticeBoardService(INoticeBoardRepository noticeBoardRepository, IUserService userService)
        {
            _noticeBoardRepository = noticeBoardRepository;
            _userService = userService;
        }

        /// <inheritdoc />
        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {

                if (request == null)
                {
                    throw new InvalidNoticeBoardRequestException("Invalid AddNoticeBoardRequest object");
                }

                if (request.ThreadTitle.IsNullOrEmpty())
                {
                    throw new InvalidThreadTitleException("The thread title cannot be null or empty");
                }

                if (request.ThreadContent.IsNullOrEmpty())
                {
                    throw new InvalidThreadContentException("The thread content cannot be null or empty");
                }

                if (request.UserId <= 0)
                {
                    throw new InvalidUserIdException("UserID is invalid");
                }

                var userEmails = _userService.GetAllUserEmails();
                var payload = "A new notice has been created, please go and check it out!";
                var emailReq = new SendEmailNotificationRequest(payload, "New Notice Created! " + request.ThreadTitle,
                    userEmails);
                
                await _notificationService.SendEmailNotification(emailReq);

                return await _noticeBoardRepository.AddNoticeBoardThread(request);
        }
        
        /// <inheritdoc />
        public async Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(
            RetrieveNoticeBoardThreadsRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid RetrieveNoticeBoardThreadsRequest object");
            }
            
            
            RetrieveNoticeBoardThreadsResponse response = new RetrieveNoticeBoardThreadsResponse(
                await _noticeBoardRepository.RetrieveAllNoticeBoardThreads(request));

            return response;
        }
        
        /// <inheritdoc />
        public async Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(
            DeleteNoticeBoardThreadRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid DeleteNoticeBoardThreadRequest Object");
            }

            if (request.ThreadId <= 0)
            {
                throw new InvalidNoticeBoardRequestException("Invalid ThreadId");
            }

            return await _noticeBoardRepository.DeleteNoticeBoardThread(request);
        }
        
        /// <inheritdoc />
        public async Task<EditNoticeBoardThreadResponse> EditNoticeBoardThread(
            EditNoticeBoardThreadRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid EditNoticeBoardThread Request");
            }

            if (request.ThreadId == 0)
            {
                throw new InvalidNoticeBoardRequestException("Invalid ThreadId");
            }

            return await _noticeBoardRepository.EditNoticeBoardThread(request);
        }

        public async Task<IncreaseEmojiResponse> IncreaseEmoji(IncreaseEmojiRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid IncreaseEmoji Request Object");
            }

            if (request.NoticeboardId == 0)
            {
                throw new InvalidNoticeBoardRequestException("Invalid ThreadId");
            }

            return await _noticeBoardRepository.IncreaseEmoji(request);
        }

        public async Task<DecreaseEmojiResponse> DecreaseEmoji(DecreaseEmojiRequest request)
        {
            if (request == null)
            {
                throw new InvalidNoticeBoardRequestException("Invalid DecreaseEmoji Request Object");
            }

            if (request.NoticeboardId <= 0)
            {
                throw new InvalidNoticeBoardRequestException("Invalid ThreadId");
            }

            return await _noticeBoardRepository.DecreaseEmoji(request);
        }
    }
}