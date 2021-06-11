using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Models;
using backend_api.User.Data;
using backend_api.User.Models.Requests;
using backend_api.User.Models.Responses;
using backend_api.User.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace backend_api.User.Controllers.Controllers
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
        [Route("RetrieveUsers")]
        public GetUserResponse GetUsers([FromQuery] GetUserRequest request)
        {
            // return await _context.users.ToListAsync();
            return service.getUser(request);
        }

        // GET: api/User/5
        [HttpGet("{id}")]
        public async Task<ActionResult<User.Models.User.User>> GetUser(int id)
        {
            var user = await _context.users.FindAsync(id);

            if (user == null)
            {
                return NotFound();
            }

            return user;
        }

        // PUT: api/User/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutUser(int id, User.Models.User.User user)
        {
            if (id != user.UserID)
            {
                return BadRequest();
            }

            _context.Entry(user).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/User
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<User.Models.User.User>> PostUser(User.Models.User.User user)
        {
            _context.users.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", new { id = user.UserID }, user);
        }

        // DELETE: api/User/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteUser(int id)
        {
            var user = await _context.users.FindAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            _context.users.Remove(user);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool UserExists(int id)
        {
            return _context.users.Any(e => e.UserID == id);
        }
    }
}
