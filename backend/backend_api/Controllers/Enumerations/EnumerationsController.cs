using System.Threading.Tasks;
using backend_api.Data.Booking;
using backend_api.Exceptions.Booking;
using backend_api.Models.Booking.Requests;
using backend_api.Models.Enumerations.Requests;
using backend_api.Services.Booking;
using backend_api.Services.Enumerations;
using backend_api.Services.User;
using Microsoft.AspNetCore.Authorization;
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
        
        [HttpGet, Authorize]
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
        
        [HttpGet, Authorize]
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
        [HttpGet, Authorize]
        [Route("GetOfficeId")]
        public async Task<ActionResult> GetOfficeId([FromQuery] GetOfficeIdRequest request)
        {
            if (request != null)
            {
                var idResponse = await _enumService.GetOfficeId(request);
                if (idResponse.OfficeLocation >= 0)
                {
                    return Ok(idResponse.OfficeLocation);
                }
                else
                {
                    return BadRequest("Error with retrieving office location ID!");
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }
        
        [HttpGet, Authorize]
        [Route("GetUserRoleId")]
        public async Task<ActionResult> GetUserRoleId([FromQuery] GetUserRoleIdRequest request)
        {
            if (request != null)
            {
                var userRole = await _enumService.GetUserRoleId(request);
                if (userRole.UserRole >= 0)
                {
                    return Ok(userRole.UserRole);
                }
                else
                {
                    return BadRequest("Error with retrieving user's role ID!");
                }
            }
            else
            {
                return BadRequest("Request is null or empty");
            }
        }
    }
    
    
}
