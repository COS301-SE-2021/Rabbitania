
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
            this._service = service;
        }

        [HttpPost]
        [Route("CreateForum")]
        public async Task<CreateForumResponse> CreateForum([FromBody] CreateForumRequest request)
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
    }
}