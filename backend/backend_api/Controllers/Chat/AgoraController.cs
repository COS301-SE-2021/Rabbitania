using System.Net;
using System.Text.Json;
using AgoraIO.Media;
using backend_api.Models.Chat.Requests;
using backend_api.Models.Chat.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace backend_api.Controllers.Chat
{
    [ApiController]
    [Route("[controller]")]
    public class AgoraController : ControllerBase
    {
        private readonly AgoraSettings _settings;

        public AgoraController(IOptions<AgoraSettings> settings)
        {
            _settings = settings.Value;
        }

        [HttpPost]
        public ActionResult<AgoraAuthResponse> index(AgoraAuthRequest request)
        {
            if (string.IsNullOrEmpty(_settings.AppId) || string.IsNullOrEmpty(_settings.Certificate))
            {
                return new StatusCodeResult((int)HttpStatusCode.PreconditionFailed);
            }

            var uid = request.uid.ValueKind == JsonValueKind.Number
                ? request.uid.GetUInt64().ToString()
                : request.uid.GetString();

            var tBuilder = new AccessToken(
                _settings.AppId,
                _settings.Certificate,
                request.channel,
                uid);
            
            tBuilder.addPrivilege(Privileges.kJoinChannel, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kPublishAudioStream, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kPublishVideoStream, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kPublishDataStream, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kRtmLogin, request.expiredTokens);

            return Ok(new AgoraAuthResponse(request.channel, request.uid, tBuilder.build()));
        }
    }
}