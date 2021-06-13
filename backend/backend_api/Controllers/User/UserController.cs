using System.Linq;
using System.Threading.Tasks;
using backend_api.Data.User;
using backend_api.Models.User.Requests;
using backend_api.Models.User.Responses;
using backend_api.Services.User;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Controllers.User
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService service;
        private readonly UserContext _context;

        public UserController(IUserService _service, UserContext context)
        {
            this.service = _service;
            this._context = context;//not needed once other endpoints are configured
        }

        // GET: api/User
        [HttpGet]
        [Route("GetUser")]
        public GetUserResponse GetUsers([FromQuery] GetUserRequest request)
        {
            // return await _context.users.ToListAsync();
            return service.getUser(request);
        }

        // GET: api/User/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Models.User.User>> GetUser(int id)
        {
            var user = await _context.Users.FindAsync(id);

            if (user == null)
            {
                return NotFound();
            }

            return user;
        }
        
        /// <summary>
        ///     API endpoint to edit a users profile.
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPut]
        [Route("EditProfile")]
        public EditProfileResponse EditProfile([FromBody] EditProfileRequest request)
        {
            return service.EditProfile(request);
        }
        
        [HttpGet]
        [Route("ViewProfile")]
        public ViewProfileResponse ViewProfile([FromBody] ViewProfileRequest request)
        {
            return service.ViewProfile(request);
        }

        // POST: api/User
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Models.User.User>> PostUser(Models.User.User user)
        {
            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", new { id = user.UserID }, user);
        }

        // DELETE: api/User/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _context.Users.Remove(user);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserExists(int id)
        {
            return _context.Users.Any(e => e.UserID == id);
        }
    }
}
