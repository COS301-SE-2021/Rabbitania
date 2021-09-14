using System;
using System.Net;
using System.Runtime.ConstrainedExecution;
using System.Text.Json;
using AgoraIO.Media;
using backend_api.Models.Chat.Requests;
using backend_api.Models.Chat.Responses;
using backend_api.Services.Chat;
using MailKit;
using Microsoft.AspNetCore.Authorization;
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
        private readonly IConfiguration _config;
        private readonly IChatService _chatService;

        public AgoraController(IConfiguration config, IChatService chatService)
        {
            _config = config;
            _chatService = chatService;
        }

        [HttpPost, Authorize]
        public ActionResult<AgoraAuthResponse> index(AgoraAuthRequest request)
        {
            var AppID = _config.GetValue<string>("AppSettings:AppID");
            var Cert = _config.GetValue<string>("AppSettings:AppCertificate");

            
            if (string.IsNullOrEmpty(AppID) || string.IsNullOrEmpty(Cert))
            {
                return new StatusCodeResult((int)HttpStatusCode.PreconditionFailed);
            }

            var uid = request.uid.ValueKind == JsonValueKind.Number
                ? request.uid.GetUInt64().ToString()
                : request.uid.GetString();
            
            var tBuilder = new AccessToken();
            tBuilder.Uid = uid;
            tBuilder.AppId = AppID;
            tBuilder.AppCertificate = Cert;
            tBuilder.ChannelName = request.channel;

            tBuilder.addPrivilege(Privileges.kJoinChannel, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kPublishAudioStream, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kPublishVideoStream, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kPublishDataStream, request.expiredTokens);
            tBuilder.addPrivilege(Privileges.kRtmLogin, request.expiredTokens);

            return Ok(new AgoraAuthResponse(request.channel, request.uid, tBuilder.build()));
        }
        [Route("GetAppID")]
        [HttpGet, Authorize]
        public ActionResult<string> GetEncryptedAppID()
        {
            return Ok(_chatService.Encrypt());
        }
    }
}