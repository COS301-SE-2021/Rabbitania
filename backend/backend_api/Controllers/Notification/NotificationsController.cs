using System.Net;
using System.Threading.Tasks;
using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using backend_api.Services.Notification;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Notification
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotificationsController : ControllerBase
    {
        private readonly INotificationService _service;

        public NotificationsController(INotificationService service)
        {
            this._service = service;
        }

        /// <summary>
        ///     API endpoint for retrieveNotifications
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet, Authorize]
        [Route("RetrieveNotifications")]
        public async Task<RetrieveNotificationsResponse> RetrieveNotifications([FromQuery] RetrieveNotificationRequest request)
        {
            return await _service.RetrieveNotifications(request);
        }
        
        /// <summary>
        ///     API endpoint for retrieveNotifications
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost, Authorize]
        [Route("CreateNotification")]
        public async Task<CreateNotificationResponse> CreateNotification([FromBody] CreateNotificationRequest request)
        {
            return await _service.CreateNotification(request);
        }
        
        /// <summary>
        ///     API endpoint to send an email to a user
        /// </summary>
        /// <param name="request"></param>
        /// <returns> HTTP Status response </returns>
        [HttpPost, Authorize]
        [Route("SendEmailNotification")]
        public async Task<ActionResult> SendEmailNotification([FromBody] SendEmailNotificationRequest request)
        {
            
            var response = await _service.SendEmailNotification(request);
            if (response.Response == HttpStatusCode.Accepted)
            {
                return Ok("Email(s) successfully sent.");
            }
            else
            {
                return BadRequest("Error when sending an email(s)");
            }
        }
        
    }
}
