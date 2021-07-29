
using System.Threading.Tasks;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;
using backend_api.Services.Forum;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Forum
{
    [Route("api/[controller]")]
    [ApiController]
    public class ForumController : ControllerBase
    {
        private readonly IForumService _service;

        public ForumController(IForumService service)
        {
            _service = service;
        }

        [HttpPost]
        [Route("CreateForum")]
        public async Task<CreateForumResponse> CreateForum(
            [FromBody] CreateForumRequest request)
        {
            return await _service.CreateForum(request);
        }

        [HttpGet]
        [Route("RetrieveForums")]
        public async Task<RetrieveForumsResponse> RetrieveForums(
            [FromQuery] RetrieveForumsRequest request)
        {
            return await _service.RetrieveForums(request);
        }

        [HttpDelete]
        [Route("DeleteForum")]
        public async Task<DeleteForumResponse> DeleteForum(
            [FromBody] DeleteForumRequest request)
        {
            return await _service.DeleteForum(request);
        }

        [HttpPost]
        [Route("CreateForumThread")]
        public async Task<CreateForumThreadResponse> CreateForumThread(
            [FromBody] CreateForumThreadRequest request)
        {
            return await _service.CreateForumThread(request);
        }

        [HttpGet]
        [Route("RetrieveForumThreads")]
        public async Task<RetrieveForumThreadsResponse> RetrieveForumThreads(
            [FromQuery] RetrieveForumThreadsRequest request)
        {
            return await _service.RetrieveForumThreads(request);
        }

        [HttpDelete]
        [Route("DeleteForumThread")]
        public async Task<DeleteForumThreadResponse> DeleteForumThread(
            [FromBody] DeleteForumThreadRequest request)
        {
            return await _service.DeleteForumThread(request);
        }

        [HttpPost]
        [Route("CreateThreadComment")]
        public async Task<CreateThreadCommentResponse> CreateThreadComment(
            [FromBody] CreateThreadCommentRequest request)
        {
            return await _service.CreateThreadComment(request);
        }

        [HttpGet]
        [Route("RetrieveThreadComments")]
        public async Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(
            [FromQuery] RetrieveThreadCommentsRequest request)
        {
            return await _service.RetrieveThreadComments(request);
        }

        [HttpDelete]
        [Route("DeleteThreadComment")]
        public async Task<DeleteThreadCommentResponse> DeleteThreadComment(
            [FromBody] DeleteThreadCommentRequest request)
        {
            return await _service.DeleteThreadComment(request);
        }
    }
}