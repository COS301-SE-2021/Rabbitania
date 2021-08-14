using System.Threading.Tasks;
using backend_api.Data.Booking;
using backend_api.Exceptions.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Enumerations.Requests;
using backend_api.Services.Booking;
using backend_api.Services.Enumerations;
using backend_api.Services.User;
using Microsoft.AspNetCore.Mvc;

namespace backend_api.Controllers.Enumerations
{
    [Route("api/[controller]")]
    [ApiController] 
    public class EnumerationsController : ControllerBase 
    {
        private readonly IEnumService _enumService;
        
        public EnumerationsController(IEnumService enumService)
        {
            _enumService = enumService;
        }
        
        [HttpGet]
        [Route("GetOfficeName")]
        public async Task<ActionResult> GetOfficeName([FromQuery] GetOfficeNameRequest request)
        {
            if (request != null)
            {
                var bookings = await _enumService.GetOfficeName(request);
                if (bookings.Response.Length > 0)
                {
                    return Ok(bookings.Response);
                }
                else
                {
                    return BadRequest("Error with retrieving office location name!");
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }
        
        [HttpGet]
        [Route("GetUserRoleType")]
        public async Task<ActionResult> GetUserRoleType([FromQuery] GetUserRoleTypeRequest request)
        {
            if (request != null)
            {
                var userRole = await _enumService.GetUserRoleType(request);
                if (userRole.Response.Length > 0)
                {
                    return Ok(userRole.Response);
                }
                else
                {
                    return BadRequest("Error with retrieving user's role type!");
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }
    }
}
