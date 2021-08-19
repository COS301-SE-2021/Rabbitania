using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Services.NoticeBoard;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.NoticeBoard
{
    [Route("api/[controller]")]
    [ApiController]
    public class NoticeBoardController : ControllerBase
    {
        private readonly INoticeBoardService _service;

        public NoticeBoardController(INoticeBoardService service)
        {
            this._service = service;
        }

        /// <summary>
        /// API endpoint to create a notice board thread
        /// </summary>
        /// <param name="request">Details of the notice board thread to create</param>
        /// <returns>HTTP status code Created or BadRequest</returns>
        [HttpPost, Authorize]
        [Route("AddNoticeBoardThread")]
        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread(
            [FromBody] AddNoticeBoardThreadRequest request)
        {
            return await _service.AddNoticeBoardThread(request);
        }
        
        
        /// <summary>
        /// API endpoint to retrieve all noticeboard threads in the system
        /// </summary>
        /// <param name="request"></param>
        /// <returns>A list of noticeboard threads along with an ACCEPTED response, or BadRequest if unsuccesful</returns>
        [HttpGet, Authorize]
        [Route("RetrieveNoticeBoardThreads")]
        public async Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(
            [FromQuery] RetrieveNoticeBoardThreadsRequest request)
        {
            return await _service.RetrieveNoticeBoardThreads(request);
        }

        /// <summary>
        /// API enpoint to delete a noticeboard thread
        /// </summary>
        /// <param name="request">the Id of the thread to delete</param>
        /// <returns>HTTP status code Deleted or BadRequest</returns>
        [HttpDelete, Authorize]
        [Route("DeleteNoticeBoardThread")]
        public async Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(
            [FromBody] DeleteNoticeBoardThreadRequest request)
        {
            return await _service.DeleteNoticeBoardThread(request);
        }

        /// <summary>
        /// API endpoint to edit a noticeboard thread
        /// </summary>
        /// <param name="request">The details of the noticeboard thread to edit</param>
        /// <returns>HTTP status code Accepted or BadRequest</returns>
        [HttpPut, Authorize]
        [Route("EditNoticeBoardThread")]
        public async Task<EditNoticeBoardThreadResponse> EditNoticeBoardThread(
            [FromBody] EditNoticeBoardThreadRequest request)
        {
            return await _service.EditNoticeBoardThread(request);
        }


    }
}