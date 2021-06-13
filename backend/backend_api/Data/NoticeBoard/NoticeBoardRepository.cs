using System.Linq;
using System.Threading.Tasks;
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

        public AddNoticeBoardThreadResponse AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {
            var threadId = request.ThreadId;
            var threadTitle = request.ThreadTitle;
            var threadContent = request.ThreadContent;
            var minLevel = request.MinLevel;
            var imageUrl = request.ImageUrl;
            var permittedUserRoles = request.PermittedUserRoles;
            var userId = request.UserId;

            Models.NoticeBoard.NoticeBoard noticeBoardThread = new Models.NoticeBoard.NoticeBoard(threadId, threadTitle,
                threadContent, minLevel, imageUrl, permittedUserRoles, userId);

            _noticeBoard.NoticeBoard.Add(noticeBoardThread);
            _noticeBoard.SaveChanges();
            
            
            return new AddNoticeBoardThreadResponse("NoticeBoard Thread Successfully added");
        }
    }
}