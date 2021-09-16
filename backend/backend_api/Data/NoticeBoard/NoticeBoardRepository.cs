using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using backend_api.Exceptions.NoticeBoard;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.Differencing;
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

        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(AddNoticeBoardThreadRequest request)
        {
            /*var threadId = request.ThreadId;*/
            var threadTitle = request.ThreadTitle;
            var threadContent = request.ThreadContent;
            var minLevel = request.MinLevel;
            var imageUrl = request.ImageUrl;
            var permittedUserRoles = request.PermittedUserRoles;
            var userId = request.UserId;
            var icon1 = request.Icon1;
            var icon2 = request.Icon2;
            var icon3 = request.Icon3;
            var icon4 = request.Icon4;

            Models.NoticeBoard.NoticeBoard noticeBoardThread = new Models.NoticeBoard.NoticeBoard(threadTitle,
                threadContent, minLevel, imageUrl, permittedUserRoles, userId, icon1, icon2, icon3, icon4);

            _noticeBoard.NoticeBoard.Add(noticeBoardThread);
            await _noticeBoard.SaveChanges();
            
            
            return new AddNoticeBoardThreadResponse(HttpStatusCode.Created);
        }

        public async Task<EditNoticeBoardThreadResponse> EditNoticeBoardThread(EditNoticeBoardThreadRequest request)
        {
            var threadID = request.ThreadId;
            var toUpdate = await _noticeBoard.NoticeBoard.FirstOrDefaultAsync(x => x.ThreadId == threadID);
            if (toUpdate == null)
            {
                return new EditNoticeBoardThreadResponse(HttpStatusCode.BadRequest);
            }
            toUpdate.ImageUrl = request.ImageUrl;
            toUpdate.ThreadContent = request.ThreadContent;
            toUpdate.ThreadTitle = request.ThreadTitle;
            toUpdate.Icon1 = request.Icon1;
            toUpdate.Icon2 = request.Icon2;
            toUpdate.Icon3 = request.Icon3;
            toUpdate.Icon4 = request.Icon4;
            try
            {
                _noticeBoard.NoticeBoard.Update(toUpdate).State = EntityState.Modified;
                await _noticeBoard.SaveChanges();
                return new EditNoticeBoardThreadResponse(HttpStatusCode.Accepted);
            }
            catch (Exception)
            {
                return new EditNoticeBoardThreadResponse(HttpStatusCode.BadRequest);
            }
        }

        public async Task<List<Models.NoticeBoard.NoticeBoard>> RetrieveAllNoticeBoardThreads(
            RetrieveNoticeBoardThreadsRequest request)
        {
            var threads = await _noticeBoard.NoticeBoard.OrderBy(id=>id.ThreadId).ToListAsync();

            return threads;
        }

        public async Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(
            DeleteNoticeBoardThreadRequest request)
        {
            try
            {
                var threadToDelete = await _noticeBoard.NoticeBoard.FirstOrDefaultAsync(x => x.ThreadId == request.ThreadId);
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

        public async Task<IncreaseEmojiResponse> IncreaseEmoji(IncreaseEmojiRequest request)
        {
            try
            {
                var toUpdate = await _noticeBoard.NoticeBoard.FirstOrDefaultAsync(x => x.ThreadId == request.NoticeboardId);
                if (request.EmojiUtf == "IconData(U+F0230)")
                {
                    toUpdate.Icon1++;
                }
                else if (request.EmojiUtf == "IconData(U+F022D)")
                {
                    toUpdate.Icon2++;
                }
                else if (request.EmojiUtf == "IconData(U+0E22B)")
                {
                    toUpdate.Icon3++;
                }
                else if (request.EmojiUtf == "IconData(U+0E0F6)")
                {
                    toUpdate.Icon4++;
                }

                await _noticeBoard.SaveChanges();
                return new IncreaseEmojiResponse("Increased Emoji", HttpStatusCode.OK);
            }
            catch (Exception e)
            {
                return new IncreaseEmojiResponse("Unexpected Error occured", HttpStatusCode.BadRequest);
            }
        }

        public async Task<DecreaseEmojiResponse> DecreaseEmoji(DecreaseEmojiRequest request)
        {
            try
            {
                var toUpdate = await _noticeBoard.NoticeBoard.FirstOrDefaultAsync(x => x.ThreadId == request.NoticeboardId);
                if (request.EmojiUtf == "IconData(U+F0230)")
                {
                    toUpdate.Icon1--;
                }
                else if (request.EmojiUtf == "IconData(U+F022D)")
                {
                    toUpdate.Icon2--;
                }
                else if (request.EmojiUtf == "IconData(U+0E22B)")
                {
                    toUpdate.Icon3--;
                }
                else if (request.EmojiUtf == "IconData(U+0E0F6)")
                {
                    toUpdate.Icon4--;
                }

                await _noticeBoard.SaveChanges();
                return new DecreaseEmojiResponse("Decreased Emoji", HttpStatusCode.OK);
            }
            catch (Exception e)
            {
                return new DecreaseEmojiResponse("Unexpected Error occured", HttpStatusCode.BadRequest);
            }
        }
    }
}