
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
        
        /// <summary>
        /// Create Forum API endpoint that will return an HTTP status code Created when an Forum has been created.
        /// </summary>
        /// <param name="request">A CreateForum Request object</param>
        /// <returns>HTTP status code Created</returns>
        [HttpPost, Authorize]
        [Route("CreateForum")]
        public async Task<CreateForumResponse> CreateForum(
            [FromBody] CreateForumRequest request)
        {
            return await _service.CreateForum(request);
        }

        /// <summary>
        /// API endpoint that returns all forums and HTTP status code ACCEPTED if the request is valid.
        /// </summary>
        /// <param name="request"></param>
        /// <returns>HTTP Status code BadRequest or Accepted</returns>
        [HttpGet, Authorize]
        [Route("RetrieveForums")]
        public async Task<RetrieveForumsResponse> RetrieveForums(
            [FromQuery] RetrieveForumsRequest request)
        {
            return await _service.RetrieveForums(request);
        }

        /// <summary>
        /// API endpoint to Edit a forum
        /// </summary>
        /// <param name="request">The details of the forum which is to be edited</param>
        /// <returns>HTTP Status code BadRequest or Accepted</returns>
        [HttpPut, Authorize]
        [Route("EditForum")]
        public async Task<EditForumResponse> EditForum(
            [FromBody] EditForumRequest request)
        {
            return await _service.EditForum(request);
        }

        /// <summary>
        /// API endpoint to Delete a forum
        /// </summary>
        /// <param name="request">the ID of the forum to delete</param>
        /// <returns>HTTP Status code BadRequest or Deleted</returns>
        [HttpDelete, Authorize]
        [Route("DeleteForum")]
        public async Task<DeleteForumResponse> DeleteForum(
            [FromBody] DeleteForumRequest request)
        {
            return await _service.DeleteForum(request);
        }

        /// <summary>
        /// API endpoint to create a forum thread using the TF-IDF algorithm
        /// </summary>
        /// <param name="request"> The details of the forum which is to be created</param>
        /// <returns>Boolean value of either true or false</returns>
        [HttpPost, Authorize]
        [Route("CreateForumThreadAPI")]
        public async Task<bool> CreateForumThreadAPI(
            [FromBody] CreateForumThreadRequest request)
        {
            return await _service.CreateForumThreadAPI(request);
        }

        /// <summary>
        /// API endpoint to create a forum thread
        /// </summary>
        /// <param name="request">The details of the forum which is to be created</param>
        /// <returns></returns>
        [HttpPost, Authorize]
        [Route("CreateForumThread")]
        public async Task<CreateForumThreadResponse> CreateForumThread(
            [FromBody] CreateForumThreadRequest request)
        {
            return await _service.CreateForumThread(request);
        }

        /// <summary>
        /// API endpoint to retrieve all forum threads held within a particular Forum 
        /// </summary>
        /// <param name="request">The Forum Id that threads we wish to return</param>
        /// <returns>HTTP status code BadRequest, or Accepted along with the required list of threads</returns>
        [HttpGet, Authorize]
        [Route("RetrieveForumThreads")]
        public async Task<RetrieveForumThreadsResponse> RetrieveForumThreads(
            [FromQuery] RetrieveForumThreadsRequest request)
        {
            return await _service.RetrieveForumThreads(request);
        }

        
        /// <summary>
        /// API endpoint to edit a particular forum thread
        /// </summary>
        /// <param name="request">the forum thread Id of the forum thread to edit</param>
        /// <returns>HTTP status code BadRequest or Accepted</returns>
        [HttpPut, Authorize]
        [Route("EditForumThread")]
        public async Task<EditForumThreadResponse> EditForumThread(
            [FromBody] EditForumThreadRequest request)
        {
            return await _service.EditForumThread(request);
        }

        /// <summary>
        /// API endpoint to Delete a particular forum thread
        /// </summary>
        /// <param name="request">the forum thread Id of the forum thread to edit</param>
        /// <returns>HTTP status code BadRequest or Accepted</returns>
        [HttpDelete, Authorize]
        [Route("DeleteForumThread")]
        public async Task<DeleteForumThreadResponse> DeleteForumThread(
            [FromBody] DeleteForumThreadRequest request)
        {
            return await _service.DeleteForumThread(request);
        }

        /// <summary>
        /// API endpoint to Create a thread comment
        /// </summary>
        /// <param name="request">The details of the thread comment to create</param>
        /// <returns>HTTP status code BadRequest or Created</returns>
        [HttpPost, Authorize]
        [Route("CreateThreadComment")]
        public async Task<CreateThreadCommentResponse> CreateThreadComment(
            [FromBody] CreateThreadCommentRequest request)
        {
            return await _service.CreateThreadComment(request);
        }

        /// <summary>
        /// API endpoint to Retrieve Thread Comments of a particular forum thread
        /// </summary>
        /// <param name="request">forum thread Id of the forum thread whose comments the requester wishes to retrieve</param>
        /// <returns>A list of forum threads and Accepted HTTP status code, or a BadRequest response</returns>
        [HttpGet, Authorize]
        [Route("RetrieveThreadComments")]
        public async Task<RetrieveThreadCommentsResponse> RetrieveThreadComments(
            [FromQuery] RetrieveThreadCommentsRequest request)
        {
            return await _service.RetrieveThreadComments(request);
        }

        /// <summary>
        /// API endpoint to Edit a specific thread comment
        /// </summary>
        /// <param name="request">Details of thread comment to edit</param>
        /// <returns></returns>
        [HttpPut, Authorize]
        [Route("EditThreadComment")]
        public async Task<EditThreadCommentResponse> EditThreadComment(
            [FromBody] EditThreadCommentRequest request)
        {
            return await _service.EditThreadComment(request);
        }

        /// <summary>
        /// API endpoint of thread comment to delete
        /// </summary>
        /// <param name="request">The thread comment ID to delete</param>
        /// <returns>HTTP status code Deleted or BadRequest</returns>
        [HttpDelete, Authorize]
        [Route("DeleteThreadComment")]
        public async Task<DeleteThreadCommentResponse> DeleteThreadComment(
            [FromBody] DeleteThreadCommentRequest request)
        {
            return await _service.DeleteThreadComment(request);
        }

        /// <summary>
        /// API endpoint to retrieve the number of threads currently held within the forum
        /// </summary>
        /// <param name="request"></param>
        /// <returns>the number of threads within a forum</returns>
        [HttpGet, Authorize]
        [Route("RetrieveNumThreads")]
        public async Task<RetrieveNumThreadsResponse> RetrieveNumThreads(
            [FromQuery] RetrieveNumThreadsRequest request)
        {
            return await _service.RetrieveNumThreads(request);
        }
        
        
    }
}