using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backend_api.Models.Notifications;
using backend_api.Notifications.Data;
using backend_api.Notifications.Models;
using backend_api.Notifications.Models.Requests;
using backend_api.Notifications.Models.Responses;
using backend_api.Notifications.Services;
using Newtonsoft.Json;

namespace backend_api.Notifications.Controller
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
