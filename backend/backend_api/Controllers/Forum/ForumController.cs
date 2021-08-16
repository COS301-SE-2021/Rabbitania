
using System.Threading.Tasks;
using backend_api.Models.Forum.Requests;
using backend_api.Models.Forum.Responses;
using backend_api.Services.Forum;
using Microsoft.AspNetCore.Authorization;
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

        [HttpPost, Authorize]
        [Route("CreateForum")]
        public async Task<CreateForumResponse> CreateForum(
            [FromBody] CreateForumRequest request)
        {
            return await _service.CreateForum(request);
        }

        [HttpGet, Authorize]
        [Route("RetrieveForums")]
        public async Task<RetrieveForumsResponse> RetrieveForums(
            [FromQuery] RetrieveForumsRequest request)
        {
            return await _service.RetrieveForums(request);
        }

        [HttpPut, Authorize]
        [Route("EditForum")]
        public async Task<EditForumResponse> EditForum(
            [FromBody] EditForumRequest request)
        {
            return await _service.EditForum(request);
        }

        [HttpDelete, Authorize]
        [Route("DeleteForum")]
        public async Task<DeleteForumResponse> DeleteForum(
            [FromBody] DeleteForumRequest request)
        {
            return await _service.DeleteForum(request);
        }

        [HttpPost, Authorize]
        [Route("CreateForumThreadAPI")]
        public async Task<bool> CreateForumThreadAPI(
            [FromBody] CreateForumThreadRequest request)
        {
            return await _service.CreateForumThreadAPI(request);
        }

        [HttpPost, Authorize]
        [Route("CreateForumThread")]
        public async Task<CreateForumThreadResponse> CreateForumThread(
            [FromBody] CreateForumThreadRequest request)
        {
            return await _service.CreateForumThread(request);
        }

        [HttpGet, Authorize]
        [Route("RetrieveForumThreads")]
        public async Task<RetrieveForumThreadsResponse> RetrieveForumThreads(
            [FromQuery] RetrieveForumThreadsRequest request)
        {
            return await _service.RetrieveForumThreads(request);
        }

        [HttpPut, Authorize]
        [Route("EditForumThread")]
        public async Task<EditForumThreadResponse> EditForumThread(
            [FromBody] EditForumThreadRequest request)
        {
            return await _service.EditForumThread(request);
        }

        [HttpDelete, Authorize]
        [Route("DeleteForumThread")]
        public async Task<DeleteForumThreadResponse> DeleteForumThread(
            [FromBody] DeleteForumThreadRequest request)
        {
            return await _service.DeleteForumThread(request);
        }

        [HttpPost, Authorize]
        [Route("CreateThreadComment")]
        public async Task<CreateThreadCommentResponse> CreateThreadComment(
            [FromBody] CreateThreadCommentRequest request)
        {
            return await _service.CreateThreadComment(request);
        }

        [HttpGet, Authorize]
        [Route("RetrieveThreadComments")]
        public async Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(
            [FromQuery] RetrieveThreadCommentsRequest request)
        {
            return await _service.RetrieveThreadComments(request);
        }

        [HttpPut, Authorize]
        [Route("EditThreadComment")]
        public async Task<EditThreadCommentResponse> EditThreadComment(
            [FromBody] EditThreadCommentRequest request)
        {
            return await _service.EditThreadComment(request);
        }

        [HttpDelete, Authorize]
        [Route("DeleteThreadComment")]
        public async Task<DeleteThreadCommentResponse> DeleteThreadComment(
            [FromBody] DeleteThreadCommentRequest request)
        {
            return await _service.DeleteThreadComment(request);
        }

        [HttpGet, Authorize]
        [Route("RetrieveNumThreads")]
        public async Task<RetrieveNumThreadsResponse> RetrieveNumThreads(
            [FromQuery] RetrieveNumThreadsRequest request)
        {
            return await _service.RetrieveNumThreads(request);
        }
        
        
    }
}