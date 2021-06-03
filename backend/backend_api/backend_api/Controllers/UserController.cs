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
        private readonly DatabaseContext _context;

        public UserController(DatabaseContext context)
        {
            _context = context;
        }

        /// <summary>
        ///     Get all users, for Admin purposes.
        /// </summary>
        /// <returns> List of all users </returns>
        [HttpGet("/api/GetUsers")]
        public async Task<ActionResult<IEnumerable<User>>> GetUsers()
        {
            return await _context.users.ToListAsync();
        }

        /// <summary>
        ///     Gets the user profile by their associated userIDs
        /// </summary>
        /// <param name="userID"></param>
        /// <returns> A User </returns>
        [HttpGet("/api/ViewProfile/{userID}")]
        public async Task<ActionResult<User>> GetUser(int userID)
        {
            var user = await _context.users.FindAsync(userID);

            if (user == null)
            {
                return NotFound();
            }

            return user;
        }

        /// <summary>
        ///    Retrieves a user profile and sets the updates to the DB
        ///    - Front-End will deal with the editing profile UI and information passed back.
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        [HttpPut("/api/EditProfile/{userID}")]
        public async Task<IActionResult> PutUser(int userID, User user)
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
                if (!UserExists(userID)){
                    return NotFound();
                }
                else{
                    throw;
                }
            }

            return NoContent();
        }

        /// <summary>
        ///     Creates a user and insert said into the database.
        /// </summary>
        /// <param name="user"></param>
        /// <returns>The created User </returns>
        [HttpPost("/api/CreateUser")]
        public async Task<ActionResult<User>> CreateUser(User user)
        {
            _context.users.Add(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", new { id = user.UserID }, user);
        }
        
        /// <summary>
        ///     Logs user into the system using Google OAuth
        ///     - Changes isOnline status to true
        /// </summary>
        [HttpGet("/api/Login")]
        public void LoginUser()
        {
            //TODO: Implement Login functionality using Google OAuth
        }
        
        /// <summary>
        ///     Logs a user out of the system
        ///     - Changes the isOnline status to false
        /// </summary>
        [HttpGet("/api/Logout")]
        public void LogoutUser()
        {
            //TODO: Implement Logout functionality using Google OAuth
        }
        
        
        private bool UserExists(int id)
        {
            return _context.users.Any(e => e.UserID == id);
        }
    }
}
