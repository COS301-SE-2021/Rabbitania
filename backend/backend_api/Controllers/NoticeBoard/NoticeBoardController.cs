using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Services.NoticeBoard;
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

        [HttpPost]
        [Route("AddNoticeBoardThread")]
        public async Task<AddNoticeBoardThreadResponse> AddNoticeBoardThread([FromBody] AddNoticeBoardThreadRequest request)
        {
            return await _service.AddNoticeBoardThread(request);
        }
        
        
        [HttpGet]
        [Route("RetrieveNoticeBoardThreads")]
        public async Task<RetrieveNoticeBoardThreadsResponse> RetrieveNoticeBoardThreads(
            [FromQuery] RetrieveNoticeBoardThreadsRequest request)
        {
            return await _service.RetrieveNoticeBoardThreads(request);
        }

        [HttpDelete]
        [Route("DeleteNoticeBoardThread")]
        public async Task<DeleteNoticeBoardThreadResponse> DeleteNoticeBoardThread(
            [FromBody] DeleteNoticeBoardThreadRequest request)
        {
            return await _service.DeleteNoticeBoardThread(request);
        }
        
        /*[HttpDelete]
        [Route("DeleteNoticeBoardThread")]
        public async Task<DeleteNoticeBoardThreadResponse
        */

    }
}