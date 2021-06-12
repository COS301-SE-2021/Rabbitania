using backend_api.Models.Notification.Requests;
using backend_api.Models.Notification.Responses;
using backend_api.Services.Notification;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controller.Notification
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
        [HttpGet]
        [Route("RetrieveNotifications")]
        public RetrieveNotificationsResponse RetriveNotifiations([FromQuery] RetrieveNotificationRequest request)
        {
            return _service.RetrieveNotifications(request);
        }
        
    }
}
