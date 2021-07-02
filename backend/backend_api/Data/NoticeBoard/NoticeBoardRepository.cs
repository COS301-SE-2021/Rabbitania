using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Data.NoticeBoard
{
    public class NoticeBoardRepository : INoticeBoardRepository
    {
        private readonly INoticeBoardContext _noticeBoard;

        public NoticeBoardRepository(INoticeBoardContext noticeBoard)
        {
            _noticeBoard = noticeBoard;
        }

        /// <inheritdoc />
        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {
            /*var threadId = request.ThreadId;*/
            var threadTitle = request.ThreadTitle;
            var threadContent = request.ThreadContent;
            var minLevel = request.MinLevel;
            var imageUrl = request.ImageUrl;
            var permittedUserRoles = request.PermittedUserRoles;
            var userId = request.UserId;

            Models.NoticeBoard.NoticeBoard noticeBoardThread = new Models.NoticeBoard.NoticeBoard(threadTitle,
                threadContent, minLevel, imageUrl, permittedUserRoles, userId);

            _noticeBoard.NoticeBoard.Add(noticeBoardThread);
            await _noticeBoard.SaveChanges();
            
            
            return new AddNoticeBoardThreadResponse(HttpStatusCode.Created);
        }

        /// <inheritdoc />
        public async Task<List<Models.NoticeBoard.NoticeBoard>> RetrieveAllNoticeBoardThreads(
            RetrieveNoticeBoardThreadsRequest request)
        {
            List<Models.NoticeBoard.NoticeBoard> threads = _noticeBoard.NoticeBoard.ToList();

            return threads;
        }

        /// <inheritdoc />
        public async Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(
            DeleteNoticeBoardThreadRequest request)
        {
            try
            {
                var threadToDelete = _noticeBoard.NoticeBoard.Find(request.ThreadId);
                if (threadToDelete != null)
                {
                    _noticeBoard.NoticeBoard.Remove(threadToDelete);
                }
                else
                {
                    throw new InvalidNoticeBoardRequestException("Thread Id not found in database");
                }

                await _noticeBoard.SaveChanges();

                return new DeleteNoticeBoardThreadResponse(HttpStatusCode.Accepted);
            }
            catch(InvalidNoticeBoardRequestException e)
            {
                return new DeleteNoticeBoardThreadResponse(HttpStatusCode.BadRequest);
            }
        }
    }
}