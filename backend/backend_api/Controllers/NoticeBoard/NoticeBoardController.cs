using System.Threading.Tasks;
using backend_api.Models.NoticeBoard.Requests;
using backend_api.Models.NoticeBoard.Responses;
using backend_api.Services.NoticeBoard;
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

    }
}