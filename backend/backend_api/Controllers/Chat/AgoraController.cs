using System.Net;
using System.Text.Json;
using AgoraIO.Media;
using backend_api.Models.Chat.Requests;
using backend_api.Models.Chat.Responses;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Options;

namespace backend_api.Controllers.Chat
{
    [ApiController]
    [Route("api/[controller]")]
    public class AgoraController : ControllerBase
    {
        private readonly AgoraSettings _settings;

        public AgoraController(IOptions<AgoraSettings> settings)
        {
            _settings = settings.Value;
        }

        [HttpPost]
        public ActionResult<AgoraAuthResponse> index(AgoraAuthRequest request, IConfiguration configuration)
        {
            var settings = configuration.GetSection("AgoraSettings");
            
            if (string.IsNullOrEmpty("e718dc1d125d4b59a3026ac5a600d65b") || string.IsNullOrEmpty("242a4dd6ab8e42b991df00b8bfa0a022"))
            {
                return new StatusCodeResult((int)HttpStatusCode.PreconditionFailed);
            }

            var uid = request.uid.ValueKind == JsonValueKind.Number
                ? request.uid.GetUInt64().ToString()
                : request.uid.GetString();

            var tBuilder = new AccessToken(
                settings.GetSection("AppID").Value,
                settings.GetSection("AppCertificate").Value,
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