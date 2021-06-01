using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backend_api.Models;

namespace backend_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        // Context variable
        private readonly DatabaseContext _context;

        public UserController(DatabaseContext context){
            // Dependency Injection 
            this._context = context;
        }

        /// <summary>
        /// My method does stuff.
        /// </summary>
        [HttpGet("/GetAllUsers")]
        public async Task<ActionResult<IEnumerable<User>>> GetAllUsers()
        {
            return await _context.users.ToListAsync();
        }

        // GET: api/User/5
        [HttpGet("/ViewUserDetails/{userID}")]
        public async Task<ActionResult<User>> ViewUserDetails(int userID)
        {
            var returnedUser = await _context.users.FindAsync(userID);

            if (returnedUser == null)
            {
                return NotFound();
            }

            return returnedUser;
        }

        // PUT: api/User/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("/EditUser/{userID}")]
        public async Task<IActionResult> EditUser(int userID, User user)
        {
            if (userID != user.UserID)
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
                if (!UserExists(userID))
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
        [HttpPost ("/CreateNewUser")]
        public async Task<ActionResult<User>> CreateNewUser(User user)
        {
            _context.users.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("ViewUserDetails", new { id = user.UserID }, user);
        }

        // DELETE: api/User/5
        [HttpDelete("/Delete/{userID}")]
        public async Task<IActionResult> DeleteUser(int userID)
        {
            var user = await _context.users.FindAsync(userID);
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
