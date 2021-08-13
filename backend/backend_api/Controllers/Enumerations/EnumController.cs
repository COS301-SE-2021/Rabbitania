using backend_api.Services.Booking;
using backend_api.Services.User;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Enumerations
{
    [Route("api/[controller]")]
    [ApiController] 
    public class EnumController : ControllerBase 
    {
        private readonly IUserService _userService;
        private readonly IBookingService _bookingService; 
        
        public EnumController(IUserService userService, IBookingService bookingService)
        { 
            _userService = userService;
            _bookingService = bookingService;
        }
    }
}
